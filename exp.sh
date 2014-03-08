#!/bin/bash
if [ "$1" == "-h" -o "$1" == "--help" ]; then
 echo -e "Usage: expscpt.sh [OPTIONS]...\n\
#######################################\n\
#             expscpt.sh              #\n\
#             07/14/2012              #\n\
#      Written By David Holdeman      #\n\
#  Makes comment boxes like this one  #\n\
#######################################\n\n\
  -h, --help        Display this help and exit\n\
  -l, --limit [NUMBER]       Limit lines at certain number of chars\n"
 exit
elif [ "$1" == "-l" -o "$1" == "--limit" ]; then
 LIMIT=$2
fi

diags_zenity()
{
 CHAR=`zenity --entry --text="Enter the character(s) to use for the box borders"`
 SPACES=`zenity --entry --text="Enter number of spaces before and after words"`
 SNAME=`zenity --entry --text="Enter the name of the script"`
 CAL=`zenity --calendar --text="Select the day the script was written"`
 WNAME=`zenity --entry --text="Enter the name of the writer"`
 ABOUT=`zenity --entry --text="Explain the purpose of the script in a few words"`
 FILE=`zenity --file-selection`
}

diags_dialog()
{
 CHAR=`dialog --stdout --inputbox "Enter character(s) to use for the box borders" 10 50` || exit 1
 SPACES=`dialog --stdout --inputbox "Enter number of spaces before and after words" 10 50` || exit 1
 SNAME=`dialog --stdout --inputbox "Enter the name of the script" 10 50` || exit 1
 CAL=`dialog --stdout --calendar "Select the day the script was written" 0 0` || exit 1
 WNAME=`dialog --stdout --inputbox "Enter the name of the writer" 10 50` || exit 1
 ABOUT=`dialog --stdout --inputbox "Explain the purpose of the script in a few words" 10 50` || exit 1
 FILE=`dialog --stdout --fselect / 10 50` || exit 1
}

diags_whiptail()
{
 CHAR=`whiptail --inputbox "Enter character(s) to use for the box borders" 10 50 3>&1 1>&2 2>&3` || exit 1
 SPACES=`whiptail --inputbox "Enter number of spaces before and after words" 10 50 3>&1 1>&2 2>&3` || exit 1
 SNAME=`whiptail --inputbox "Enter the name of the script" 10 50 3>&1 1>&2 2>&3` || exit 1
 CAL=`whiptail --inputbox "Enter the day the script was written." 10 50 3>&1 1>&2 2>&3` || exit 1
 WNAME=`whiptail --inputbox "Enter the name of the writer" 10 50 3>&1 1>&2 2>&3` || exit 1
 ABOUT=`whiptail --inputbox "Explain the purpose of the script in a few words" 10 50 3>&1 1>&2 2>&3` || exit 1
 FILE=`whiptail --inputbox "Enter the pathname for the file in which to store the box." 10 50 3>&1 1>&2 2>&3` || exit 1
}

diags_read()
{
 read -p "Enter the character(s) to use for the box borders  " CHAR
 read -p "Enter the number of spaces before and after words  " SPACES
 read -p "Enter the name of the script  " SNAME
 read -p "Enter the day the script was written.  " CAL
 read -p "Enter the name of the writer " WNAME
 read -p "Explain the purpose of the script in a few words  " ABOUT
 read -p "Enter the pathname for the file in which to store the box  " FILE
}

# If script is run from a X environment
# Try zenity first
# But if not, try zenity next to last
# Always try read last
if [ $XAUTHORITY ]; then
 if which zenity >> /dev/null; then
  diags_zenity
 elif which dialog >> /dev/null; then
  diags_dialog
 elif which whiptail >> /dev/null; then
  diags_whiptail
 else
  diags_read
 fi
else
 if which dialog >> /dev/null; then
  diags_dialog
 elif which whiptail >> /dev/null; then
  diags_whiptail
 elif which zenity >> /dev/null; then
  diags_zenity
 else
  diags_read
 fi
fi
VARIABLES="SNAME CAL WNAME ABOUT"
WNAME="Written By $WNAME"

splitter()
{
 # Usage: splitter <string to be split>
 # LIMIT is number of chars
 # Splits at words, not strict
 # Sets VAR<n>; e.g. VAR1, VAR2, ...
 for ((i=1;; i++)); do
  read VAR$i || break;
  VARS=$((VARS+1))
 done <<lineToSplit
`if [ $LIMIT ]; then echo "$@" | fold -sw $LIMIT; else echo $@; fi`
lineToSplit
}

center()
{
 # VAR and PADDING must be set
 LINES="$LINES$CHAR"`echo -e $VAR | sed -e :a -e "s/^.\{1,$PADDING\}$/ & /;ta"`
 LEN=${#VAR}
 if [ $((LEN%2)) -eq 0 -a $((PADDING%2)) -eq 0 ]; then
  LINES="$LINES$CHAR"
 elif [ $((LEN%2)) -eq 0 -a $((PADDING%2)) -ne 0 ]; then
  LINES="$LINES $CHAR"
 elif [ $((LEN%2)) -ne 0 -a $((PADDING%2)) -ne 0 ]; then
  LINES="$LINES$CHAR"
 elif [ $((LEN%2)) -ne 0 -a $((PADDING%2)) -eq 0 ]; then
  LINES="$LINES $CHAR"
 fi
}

findlongest()
{
 # Usage: findlongest VAR1 VAR2 ...
 LONGEST=0
 for i in $@; do
  if [ $((`eval echo "$""$i" | wc -c`-1)) -gt $LONGEST ]; then
   LONGEST=$((`eval echo "$""$i" | wc -c`-1))
   LONGESTVAR="$i"
  fi
 done
}

border()
{
 LINES="$LINES$CHAR"
 for ((i=0; i<=$((PADDING+1)); i++)); do
  LINES="$LINES"`echo $CHAR | head -c 1`
 done
 LINES="$LINES$CHAR"
 LINES="$LINES\n"
}

findlongest $VARIABLES
PADDING=$(($((LONGEST+$((SPACES*2))))-2))
border
for i in $VARIABLES; do
 splitter $(eval echo "$""$i")
 for ((i=1; i <=$VARS; i++)); do
  VAR=`eval echo "$""VAR""$i"`
  center
  LINES="$LINES\n"
 done
 VARS=0
done
border
echo -e "$LINES" >> "$FILE"
exit
