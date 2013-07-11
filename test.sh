#!/bin/bash
A="heoi"
B="aoetihl"
C="ah.,ircdrcoadiro"
D="aoitatlomilh"

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

findlongest A B C D
echo $LONGEST
echo $LONGESTVAR
exit
