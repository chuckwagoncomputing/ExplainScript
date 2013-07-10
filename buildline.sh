# CHAR     Border Char(s)
# SPACES   Number of Spaces for Padding
# SNAME    Script Name
# CAL      Date
# WNAME    Author
# ABOUT    About Info
# FILE     File in which to save Box

WNAME="Written By $WNAME"

if [ $LIMIT ]; then
# look for vars which are longer than the limit once padding and chars are added
# split them
end

# find longest
# find how much spacing is req'd
# VAR = the variable we are working with
# PADDING = ($SPACES - (((`echo $CHAR | wc -c')-1) x 2)

center()
{
PADDING=$((PADDING-2))
LINES="$LINES$CHAR"`echo -e $VAR | sed -e :a -e "s/^.\{1,$PADDING\}$/ & /;ta"`
LEN=`echo $VAR | wc -c`
LEN=$((LEN-1))
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

LINES="$LINES\n"
