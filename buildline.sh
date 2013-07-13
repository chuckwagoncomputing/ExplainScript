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
