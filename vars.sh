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
 CAL=`whiptail --inputbox "Enter the day the script was written. Format: mm/dd/yyyy" 10 50 3>&1 1>&2 2>&3` || exit 1
 WNAME=`whiptail --inputbox "Enter the name of the writer" 10 50 3>&1 1>&2 2>&3` || exit 1
 ABOUT=`whiptail --inputbox "Explain the purpose of the script in a few words" 10 50 3>&1 1>&2 2>&3` || exit 1
 FILE=`whiptail --inputbox "Enter the pathname for the file in which to store the box." 10 50 3>&1 1>&2 2>&3` || exit 1
}
diags_read()
{
 read -p "Enter the character(s) to use for the box borders" CHAR
 read -p "Enter the number of spaces before and after words" SPACES
 read -p "Enter the name of the script" SNAME
 read -p "Enter the day the script was written. Format: mm/dd/yyyy" CAL
 read -p "Enter the name of the writer" WNAME
 read -p "Explain the purpose of the script in a few words" ABOUT
 read -p "Enter the pathname for the file in which to store the box" FILE
}

# If script is run from a X environment
# Try Zenity first
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
