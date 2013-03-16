#!/bin/bash
#*************************************#
#             expscpt.sh              #
#             07/14/2012              #
#      Written By David Holdeman      #
#                                     #
#  Makes comment boxes like this one  #
#*************************************#

# This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.

if [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
 echo -e "Usage: expscpt.sh [OPTIONS]...\n#*************************************#\n#             expscpt.sh              #\n#             07/14/2012              #\n#      Written By David Holdeman      #\n#                                     #\n#  Makes comment boxes like this one  #\n#*************************************#\n\n  -h, --help        Display this help and exit\n  -l [NUMBER]       Limit lines at certain number of chars\n"
 exit
elif [ "$1" = "-l" ]
then
 if [ $2 -eq $2 ] || [ $2 != "" ] 2> /dev/null
 then
  MAXLENGTHA=$2
  MAXLENGTH=`echo $(( MAXLENGTHA-$(($((CHAR*2 ))+$(echo $CHAR | wc -c)))))`
 else
  echo "Error: Value for max is not a number"
  exit 1
 fi
else
 :
fi

numlist()
{
 BASHV=`echo $BASH_VERSION | head -c 1`
 if which seq >> /dev/null
 then
  seq $1
 elif which jot >> /dev/null
 then
  jot $1
 elif [ $BASHV -ge 3 ]
 then
  eval echo {1..$1}
 else
  echo "Sorry, this program is not compatible with your computer. Please contact me at cook@holdemanenterprises.com"
  exit 1
 fi
}

diags_zenity()
{
 CHAR=`zenity --entry --text="Enter the character(s) to use for the box borders"`
 SPACES=`zenity --entry --text="Enter number of spaces before and after words"`
 SNAME=`zenity --entry --text="Enter the name of the script"`
 CALA=`zenity --calendar --text="Select the day the script was written"`
 WNAME=`zenity --entry --text="Enter the name of the writer"`
 ABOUT=`zenity --entry --text="Explain the purpose of the script in a few words"`
 FILE=`zenity --file-selection`
}

diags_dialog()
{
 CHAR=`dialog --stdout --inputbox "Enter character(s) to use for the box borders" 10 50` || exit 1
 SPACES=`dialog --stdout --inputbox "Enter number of spaces before and after words" 10 50` || exit 1
 SNAME=`dialog --stdout --inputbox "Enter the name of the script" 10 50` || exit 1
 CALA=`dialog --stdout --calendar "Select the day the script was written" 0 0` || exit 1
 WNAME=`dialog --stdout --inputbox "Enter the name of the writer" 10 50` || exit 1
 ABOUT=`dialog --stdout --inputbox "Explain the purpose of the script in a few words" 10 50` || exit 1
 FILE=`dialog --stdout --fselect / 10 50` || exit 1
}

diags_whiptail()
{
 CHAR=`whiptail --inputbox "Enter character(s) to use for the box borders" 10 50 3>&1 1>&2 2>&3` || exit 1
 SPACES=`whiptail --inputbox "Enter number of spaces before and after words" 10 50 3>&1 1>&2 2>&3` || exit 1
 SNAME=`whiptail --inputbox "Enter the name of the script" 10 50 3>&1 1>&2 2>&3` || exit 1
 CALA=`whiptail --inputbox "Enter the day the script was written. Format: mm/dd/yyyy" 10 50 3>&1 1>&2 2>&3` || exit 1
 WNAME=`whiptail --inputbox "Enter the name of the writer" 10 50 3>&1 1>&2 2>&3` || exit 1
 ABOUT=`whiptail --inputbox "Explain the purpose of the script in a few words" 10 50 3>&1 1>&2 2>&3` || exit 1
 FILE=`whiptail --inputbox "Enter the pathname for the file in which to store the box." 10 50 3>&1 1>&2 2>&3` || exit 1
}

diags_read()
{
 echo "Enter the character(s) to use for the box borders"
 read CHAR
 echo "Enter the number of spaces before and after words"
 read SPACES
 echo "Enter the name of the script"
 read SNAME
 echo "Enter the day the script was written. Format: mm/dd/yyyy"
 read CALA
 echo "Enter the name of the writer"
 read WNAME
 echo "Explain the purpose of the script in a few words"
 read ABOUT
 echo "Enter the pathname for the file in which to store the box"
 read FILE
}

if [ $XAUTHORITY ]
then
 if which zenity >> /dev/null
 then
  diags_zenity
 elif which dialog >> /dev/null
 then
  diags_dialog
 elif which whiptail >> /dev/null
 then
  diags_whiptail
 else
  diags_read
 fi
else
 if which dialog >> /dev/null
 then
  diags_dialog
 elif which whiptail >> /dev/null
 then
  diags_whiptail
 elif which zenity >> /dev/null
 then
  diags_zenity
 else
  diags_read
 fi
fi
if [ $SPACES -eq $SPACES ] 2> /dev/null
then
 :
else
 echo "Error: Value for Spaces is not a number"
 exit 1
fi
if CAL=`echo $CALA | grep '[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]'`
then
 :
else
 echo "Error: Date not formatted correctly"
 exit 1
fi
SSTRA=`echo $SNAME | wc -c`
WSTRA=`echo $WNAME | wc -c`
ASTRA=`echo $ABOUT | wc -c`
SSTRB=$(( SSTRA - 1 ))
CSTR=10
WSTRB=$(( WSTRA + 10 ))
ASTRB=$(( ASTRA - 1 ))
ADIFFSC=$(( SSTRB - CSTR ))
ADIFFSW=$(( SSTRB - WSTRB ))
ADIFFSA=$(( SSTRB - ASTRB ))
ADIFFWS=$(( WSTRB - SSTRB ))
ADIFFWC=$(( WSTRB - CSTR ))
ADIFFWA=$(( WSTRB - ASTRB ))
ADIFFAS=$(( ASTRB - SSTRB ))
ADIFFAC=$(( ASTRB - CSTR ))
ADIFFAW=$(( ASTRB - WSTRB ))
BDIFFSC=$(( ADIFFSC / 2 ))
BDIFFSW=$(( ADIFFSW / 2 ))
BDIFFSA=$(( ADIFFSA / 2 ))
BDIFFWS=$(( ADIFFWS / 2 ))
BDIFFWC=$(( ADIFFWC / 2 ))
BDIFFWA=$(( ADIFFWA / 2 ))
BDIFFAS=$(( ADIFFAS / 2 ))
BDIFFAC=$(( ADIFFAC / 2 ))
BDIFFAW=$(( ADIFFAW / 2 ))
REMSC=$(( ADIFFSC % 2 ))
REMSW=$(( ADIFFSW % 2 ))
REMSA=$(( ADIFFSA % 2 ))
REMWS=$(( ADIFFWS % 2 ))
REMWC=$(( ADIFFWC % 2 ))
REMWA=$(( ADIFFWA % 2 ))
REMAS=$(( ADIFFAS % 2 ))
REMAC=$(( ADIFFAC % 2 ))
REMAW=$(( ADIFFAW % 2 ))

print_hash()
{
 echo -n "$CHAR" >> $FILE
}

print_hashend()
{
 echo "$CHAR" >> $FILE
}

print_doingy()
{
 echo -n "*" >> $FILE
}

print_space()
{
 echo -n " " >> $FILE
}

print_date()
{
 echo -n $CAL >> $FILE
}

print_writ()
{
 echo -n "Written By $WNAME" >> $FILE
}

prep_sname()
{
 for w in $SNAME
 do
  THISWORD=`echo $w | wc -c`
  TOTAL=$(( TOTAL + THISWORD ))
  if [ $(( TOTAL - 1 )) -ge $MAXLENGTH ]
  then
   for i in $(numlist $SPACES)
   do
    SNAMEVAR="$SNAMEVAR "
    continue
   done
   if [ $1 = "s" ]
   then
    :
   elif [ $1 = "w" ]
   then
    ADIFFWS=$(( WSTRB - TOTAL ))
    BDIFFWS=$(( ADIFFWS / 2 ))
   elif [ $1 = "a" ]
   then
    ADIFFAS=$(( ASTRB - TOTAL ))
    BDIFFAS=$(( ADIFFAS / 2 ))
   else
    echo "Error: invalid prep_sname option"
    exit 1
   fi
   SNAMEVAR="$SNAMEVAR#\n"
   SNAMEVAR="$SNAMEVAR#"
   for i in $(numlist $SPACES)
   do
    SNAMEVAR="$SNAMEVAR "
    continue
   done
   TOTAL=$THISWORD
  else
  if [ $TOTAL -eq $THISWORD ]
  then
   :
   else
   LINE="$LINE "
  fi
 fi
 LINE="$LINE$w"
 done
}

print_sname()
{
 if [ $1 = "s" ]
 then
  for i in $(numlist $SPACES)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
  SNAMEVAR="$SNAMEVAR$SNAME"
  for i in $(numlist $SPACES)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
 elif [ $1 = "w" ]
 then
  for i in $(numlist $SPACES)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
  for i in $(numlist $BDIFFWS)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
  SNAMEVAR=`echo -n $SNAME`
  for i in $(numlist $BDIFFWS)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
  for i in $(numlist $SPACES)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
  if [ $REMWS -eq 1 ]
  then
   SNAMEVAR="$SNAMEVAR "
  else
   :
  fi
  elif [ $1 = "a" ]
  then
  for i in $(numlist $SPACES)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
  for i in $(numlist $BDIFFAS)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
  SNAMEVAR=`echo -n $SNAME`
  for i in $(numlist $BDIFFAS)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
  for i in $(numlist $SPACES)
  do
   SNAMEVAR="$SNAMEVAR "
   continue
  done
  if [ $REMAS -eq 1 ]
  then
   SNAMEVAR="$SNAMEVAR "
  else
   :
  fi
 else
  echo "Error: invalid prep_sname option"
  exit 1
 fi
}

prep_wname()
{
 for w in $WNAME
 do
  THISWORD=`echo $w | wc -c`
  TOTAL=$(( TOTAL + THISWORD ))
  if [ $(( TOTAL - 1 )) -ge $MAXLENGTH ]
  then
   for i in $(numlist $SPACES)
   do
    WNAMEVAR="$WNAMEVAR "
    continue
   done
   if [ $1 = "s" ]
   then
    ADIFFSW=$(( SSTRB - TOTAL ))
    BDIFFSW=$(( ADIFFSW / 2 ))
   elif [ $1 = "w" ]
   then
    :
   elif [ $1 = "a" ]
   then
    ADIFFAW=$(( ASTRB - TOTAL ))
    BDIFFAW=$(( ADIFFAW / 2 ))
   else
    echo "Error: invalid print_wname option"
    exit 1
   fi
   WNAMEVAR="$WNAMEVAR#\n"
   WNAMEVAR="$WNAMEVAR#"
   for i in $(numlist $SPACES)
   do
    WNAMEVAR="$WNAMEVAR "
    continue
   done
   TOTAL=$THISWORD
   else
    if [ $TOTAL -eq $THISWORD ]
    then
     :
    else
     LINE="$LINE "
    fi
   fi
   LINE="$LINE$w"
  done
}

print_wname()
{
 if [ $1 = "s" ]
 then
  for i in $(numlist $SPACES)
  do
   WNAMEVAR="$WNAMEVAR "
   continue
  done
  for i in $(numlist $BDIFFSW)
  do
   WNAMEVAR="$WNAMEVAR "
   continue
  done
  WNAMEVAR="${WNAMEVAR}Written By: $WRIT"
  for i in $(numlist $BDIFFSW)
  do
   WNAMEVAR="$WNAMEVAR "
   continue
  done
  for i in $(numlist $SPACES)
  do
   WNAMEVAR="$WNAMEVAR "
   continue
  done
  if [ $REMSW -eq 1 ]
  then
   WNAMEVAR="$WNAMEVAR "
  else
   :
  fi
 elif [ $1 = "w" ]
 then
 for i in $(numlist $SPACES)
 do
   WNAMEVAR="$WNAMEVAR "
  continue
 done
 print_writ
 for i in $(numlist $SPACES)
 do
  WNAMEVAR="$WNAMEVAR "
  continue
 done
 elif [ $1 = "a" ]
 then
  for i in $(numlist $SPACES)
  do
   WNAMEVAR="$WNAMEVAR "
   continue
  done
  for i in $(numlist $BDIFFAW)
  do
   WNAMEVAR="$WNAMEVAR "
   continue
  done
  print_writ
  for i in $(numlist $BDIFFAW)
  do
   WNAMEVAR="$WNAMEVAR "
   continue
  done
  for i in $(numlist $SPACES)
  do
   WNAMEVAR="$WNAMEVAR "
   continue
  done
  if [ $REMAW -eq 1 ]
  then
   WNAMEVAR="$WNAMEVAR "
  else
   :
  fi
 else
  echo "Error: invalid prep_wname option"
  exit 1
 fi
}

prep_about()
{
 for w in $ABOUT
 do
  THISWORD=`echo $w | wc -c`
  TOTAL=$(( TOTAL + THISWORD ))
  if [ $(( TOTAL - 1 )) -ge $MAXLENGTH ]
  then
   for i in $(numlist $SPACES)
   do
    ABOUTVAR="$ABOUTVAR "
    continue
   done
   if [ $1 = "s" ]
   then
    ADIFFSA=$(( SSTRB - TOTAL ))
    BDIFFSA=$(( ADIFFSA / 2 ))
   elif [ $1 = "w" ]
   then
    ADIFFWA=$(( WSTRB - TOTAL ))
    BDIFFWA=$(( ADIFFWA / 2 ))
   elif [ $1 = "a" ]
   then
    :
   else
    echo "Error: invalid prep_about option"
    exit 1
   fi
   ABOUTVAR="$ABOUTVAR#\n"
   ABOUTVAR="$ABOUTVAR#"
   for i in $(numlist $SPACES)
   do
    ABOUTVAR="$ABOUTVAR "
    continue
   done
   TOTAL=$THISWORD
  else
   if [ $TOTAL -eq $THISWORD ]
   then
    :
   else
    LINE="$LINE "
   fi
  fi
  LINE="$LINE$w"
 done
}

print_about()
{
 if [ $1 = "s" ]
 then
  for i in $(numlist $SPACES)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
  for i in $(numlist $BDIFFSA)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
  echo -n $ABOUT >> $FILE
  for i in $(numlist $BDIFFSA)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
  for i in $(numlist $SPACES)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
  if [ $REMSA -eq 1 ]
  then
   ABOUTVAR="$ABOUTVAR "
  else
   :
  fi
 elif [ $1 = "w" ]
 then
  for i in $(numlist $SPACES)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
  for i in $(numlist $BDIFFWA)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
  echo -n $ABOUT >> $FILE
  for i in $(numlist $BDIFFWA)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
  for i in $(numlist $SPACES)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
  if [ $REMWA -eq 1 ]
  then
   ABOUTVAR="$ABOUTVAR "
  else
   :
  fi
 elif [ $1 = "a" ]
 then
  for i in $(numlist $SPACES)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
  ABOUTVAR="$ABOUTVAR$ABOUT"
  for i in $(numlist $SPACES)
  do
   ABOUTVAR="$ABOUTVAR "
   continue
  done
 else
  echo "Error: invalid prep_about option"
  exit 1
 fi
}

if [ -z "$SNAME" ]
then
 echo "Canceled"
 exit 0
# If Scriptname is the longest
elif [ $SSTRB -ge $WSTRB -a $SSTRB -ge $ASTRB ]
then
 if [ $MAXLENGTH ]
 then
  prep_sname
 else
  :
 fi
 print_hash
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 for i in $(numlist $SSTRB)
 do
  print_doingy
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 print_hashend
 print_hash
 echo "SNAMEVAR"
 print_hashend
 print_hash
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 for i in $(numlist $BDIFFSC)
 do
  print_space
  continue
 done
 print_date
 for i in $(numlist $BDIFFSC)
 do
  print_space
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 if [ $REMSC -eq 1 ]
 then
  print_space
 else
  :
 fi
 print_hashend
 print_hash
 print_wname s
 print_hashend
 print_hash
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 for i in $(numlist $SSTRB)
 do
  print_space
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 print_hashend
 print_hash
 print_about s
 print_hashend
 print_hash
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 for i in $(numlist $SSTRB)
 do
  print_doingy
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 print_hashend
# If writer name plus "written by" is the longest
elif [ $WSTRB -gt $SSTRB -a $WSTRB -gt $ASTRB ]
then
 if [ $MAXLENGTH ]
 then
  prep_wname
 else
  :
 fi
 print_hash
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 for i in $(numlist $WSTRB)
 do
  print_doingy
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 print_hashend
 print_hash
 print_sname w
 print_hashend
 print_hash
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 for i in $(numlist $BDIFFWC)
 do
  print_space
  continue
 done
 echo -n $CAL >> $FILE
 for i in $(numlist $BDIFFWC)
 do
  print_space
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 if [ $REMWC -eq 1 ]
 then
  print_space
 else
  :
 fi
 print_hashend
 print_hash
 echo "$WNAMEVAR"
 print_hashend
 print_hash
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 for i in $(numlist $WSTRB)
 do
  print_space
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 print_hashend
 print_hash
 print_about w
 print_hashend
 print_hash
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 for i in $(numlist $WSTRB)
 do
  print_doingy
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 print_hashend
# If About is the longest
elif [ $ASTRB -gt $SSTRB ]
then
 if [ $MAXLENGTH ]
 then
  prep_about 
 else
  :
 fi
 print_hash
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 for i in $(numlist $ASTRB)
 do
  print_doingy
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 print_hashend
 print_hash
 print_sname a
 print_hashend
 print_hash
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 for i in $(numlist $BDIFFAC)
 do
  print_space
  continue
 done
 echo -n $CAL >> $FILE
 for i in $(numlist $BDIFFAC)
 do
  print_space
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 if [ $REMAC -eq 1 ]
 then
  print_space
 else
  :
 fi
 print_hashend
 print_hash
 print_wname a
 print_hashend
 print_hash
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 for i in $(numlist $ASTRB)
 do
  print_space
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_space
  continue
 done
 print_hashend
 print_hash
 echo $ABOUTVAR
 print_hashend
 print_hash
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 for i in $(numlist $ASTRB)
 do
  print_doingy
  continue
 done
 for i in $(numlist $SPACES)
 do
  print_doingy
  continue
 done
 print_hashend
else
 echo "Error: None is greater or equal"
 exit 1
fi
exit
