#!/bin/bash
if [ "$1" == "-h" -o "$1" == "--help" ]; then
 echo -e "Usage: expscpt.sh [OPTIONS]...\n#*************************************#\n#             expscpt.sh              #\n#             07/14/2012              #\n#      Written By David Holdeman      #\n#                                     #\n#  Makes comment boxes like this one  #\n#*************************************#\n\n  -h, --help        Display this help and exit\n  -l, --limit [NUMBER]       Limit lines at certain number of chars\n"
 exit
elif [ "$1" == "-l" -o "$1" == "--limit" ]; then
LIMIT=$2
else
:
fi

# non-compatible error function
errnocomp()
{
  echo "Sorry, this program is not compatible with your computer. Please report an issue at github.com/chuckwagoncomputing/ExplainScript"
  exit 1
}

. vars.sh
. buildline.sh
echo -e "$LINES" >> $FILE
exit
