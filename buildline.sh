# CHAR     Border Char(s)
# SPACES   Number of Spaces for Padding
# SNAME    Script Name
# CAL      Date
# WNAME    Author
# ABOUT    About Info
# FILE     File in which to save Box

WNAME="Written By $WNAME"

splitter()
{
 for ((i=1;; i++)); do
  read VAR$i || break;
 done <<lineToSplit
`if [ $LIMIT ]; then echo "$@" | fold -sw $LIMIT; else; echo $@; fi`
lineToSplit
}

center()
{
 PADDING=$((PADDING-2))
 LINES="$LINES$CHAR"`echo -e $VAR | sed -e :a -e "s/^.\{1,$PADDING\}$/ & /;ta"`
 LEN=${#VAR}`
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
LONGEST=0
for i in $@
do
if [ $((`eval echo "$""$i" | wc -c`-1)) -gt $LONGEST ]; then
LONGEST=$((`eval echo "$""$i" | wc -c`-1))
LONGESTVAR=$i
fi
done
}

# find how much spacing is req'd

PADDING=$((SPACES-$((${#VAR}*2))))
LINES="$LINES\n"
