#!/bin/bash
#
#usage:
# curl -O https://raw.githubusercontent.com/kiperos/debi9/master/debi9.sh && chmod +x debi9.sh && ./debi9.sh

##############################################################################################################
spinner ()
{
    bar=" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    barlength=${#bar}
    i=0
    while ((i < 100)); do
        n=$((i*barlength / 100))
        printf "\e[00;34m\r[%-${barlength}s]\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.02
    done
}
##############################################################################################################
archivepassword=$(cat /root/pass)
##############################################################################################################

# Installing Dependencies
# Needed Prerequesites will be set up here
install_dep(){
   clear
   f_banner
   echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
   echo -e "\e[93m[+]\e[00m Setting some Prerequisites"
   echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
   echo ""
   spinner
   apt install sudo
   sudo apt -y update
   sudo apt -y clean all
   sudo apt -y install p7zip-full
   sudo apt -y install pwgen
   sudo apt -y install tmux
   say_done
}

##############################################################################################################
# Update System
update_system(){
   clear
   f_banner
   echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
   echo -e "\e[93m[+]\e[00m Updating the System"
   echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
   echo ""
   apt -y update
   apt -y upgrade
   #apt -y dist-upgrade
   say_done
}
##############################################################################################################
# Show "Done."
function say_done() {
    echo " "
    echo -e "Done."
    yes "" | say_continue
}

##############################################################################################################
# Ask to Continue
function say_continue() {
    echo -n " To EXIT Press x Key, Press ENTER to Continue"
    read acc
    if [ "$acc" == "x" ]; then
        exit
    fi
    echo " "
}
##############################################################################################################
# Show "Done."
function say_done_2() {
    echo " "
    echo -e "Done."
    say_continue_2
}
##############################################################################################################
# Ask to Continue
function say_continue_2() {
    echo -n " To EXIT Press x Key, Press ENTER to Continue"
    read acc
    if [ "$acc" == "x" ]; then
        exit
    fi
    echo " "
}
##############################################################################################################
f_banner(){
echo
echo "
 ____ _ ___    ____ _  _ ___ ____   ____ ____ ___ _  _ ___ 
 ==== | |==]   |--| |__|  |  [__]   ==== |===  |  |__| |--'
|     .-.
|    /   \         .-.
|   /     \       /   \       .-.     .-.     _   _
+--/-------\-----/-----\-----/---\---/---\---/-\-/-\/\/---
| /         \   /       \   /     '-'     '-'
|/           '-'         '-'
"
echo
echo

}


##############################################################################################################
#Download archive

download_s123(){
clear
  f_banner
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo -e "\e[93m[+]\e[00m Downloading Archive"
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo ""
cd
curl -O https://raw.githubusercontent.com/kiperos/debi9/master/s123.7z
}

##############################################################################################################

#Extract archive
extract_s123(){
clear
  f_banner
  
 ARCHIVEPASS=/root/pass
if [ -f $ARCHIVEPASS ]; then
  
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo -e "\e[93m[+]\e[00m Extract s123"
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo ""
  
  7z x s123.7z -p$archivepassword; echo "extract archive OK"
  
 else 
  echo ""
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo -e "\e[93m[+]\e[00m Extract axx archive. File with archive password doesn't exist. Please Enter Your Password!"
  echo -e "\e[34m---------------------------------------------------------------------------------------------------------\e[00m"
  echo ""
  echo -n " Please Enter Your Password: "; read -s archivepassword2
  #cd a1
  7z x s123.7z -p$archivepassword2; echo "extract archive OK"
  #rm -f a1.7z; echo "remove archive OK"
  #cd ..
  echo " OK"
  fi
say_done
}

##############################################################################################################

update_system
install_dep
download_s123
ls
sleep 1
extract_s123
#mv /root/s123/s123.sh /usr/local/bin/s123
mv /root/s123/s123.x /usr/local/bin/s123

chmod +x /usr/local/bin/s123
tmux new-session -d -s stealth s123

tmux attach
