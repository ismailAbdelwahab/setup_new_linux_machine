#!/bin/bash
################# Colors ##############################
RED=`tput bold && tput setaf 1`
GREEN=`tput bold && tput setaf 2`
YELLOW=`tput bold && tput setaf 3`
BLUE=`tput bold && tput setaf 4`
NC=`tput sgr0`
function RED(){ echo -e ${RED}${1}${NC} ;}
function GREEN(){ echo -e ${GREEN}${1}${NC} ;}
function YELLOW(){ echo -e ${YELLOW}${1}${NC} ;}
function BLUE(){ echo -e ${BLUE}${1}${NC} ;}
############ Testing if you have root priviledges ############
function checkRootPriviledge(){
if [ $UID -ne 0 ]
then
	RED "You must run this script as root!" && echo
	exit 1
fi
}
##############################################################
################## Update ###########################
function updateAndUpgradeRepos(){
	YELLOW "Updating repositories..."
	BLUE "\tUpdating repos ..."
	sudo apt update -y
	BLUE "\tUpgrading ..."
	sudo apt upgrade -y
	BLUE "\tApt autoremove ..."
	sudo apt autoremove -y
	BLUE "\tApt Autoclean ..."
	sudo apt autoclean -y
}
#####################################################
################### Utility #########################
function installBuildEssential(){
	BLUE "\tInstalling build-essential..."
	sudo apt-get install -y build-essential 
}
function installGit(){
	BLUE "\tInstalling git..."
	sudo apt-get install -y git
}
function installMacchanger(){
	BLUE "\tInstalling macchanger..."
	sudo apt-get install -y macchanger
}
function installImageMagick(){
	BLUE "\tInstalling ImageMagick..."
	sudo apt-get install -y imagemagick
}
function installTldr(){
	BLUE "\tInstalling tldr ..."
	sudo apt-get install -y tldr
}
#####################################################
############ Text/Hex/LaTeX editors #################
# Vim, Sublime Text, Atom // Bless // Gummi
function installVim(){
	BLUE "\tInstalling Vim"
	sudo apt-get install -y vim
}
function installSublimeText(){
## According to https://www.sublimetext.com/docs/3/linux_repositories.html-
	BLUE "\tInstalling Sublime Text..."
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt-get install -y apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt-get update
	sudo apt-get install -y sublime-text
}
function installAtom(){
	BLUE "\tInstalling Atom..."
	wget "https://atom.io/download/deb" -O atom.deb
	dpkg -i atom.deb
	rm atom.deb
}
function installBless(){
	BLUE "\tInstalling Bless..."
	sudo apt-get install -y bless
}
function installGummi(){
	BLUE "\tInstalling Gummi..."
	sudo apt-get install -y gummi
}
##################################################
############### Python related  ##################
# pip, requests, pwntools
function installPipForPython3(){
	BLUE "\tInstalling pip (for python3)..."
	sudo apt-get install -y python3-pip
}
function installNumpy(){
	BLUE "\tInstalling numpy..."
	sudo pip3 install numpy
}
function installMatplotlib(){
	BLUE "\tInstalling Python Matplotlib..."
	sudo pip3 install matplotlib
}
function installPythonRequests(){
	BLUE "\tInstalling python-requests..."
	sudo pip3 install requests
}
function installPwntools(){
	BLUE "\tInstalling Python pwntools..."
	sudo pip3 install pwntools
}

function installPythonTools(){
	installPipForPython3
	installNumpy
	installMatplotlib
	installPythonRequests
	installPwntools
}
##################################################
################ Networking ######################
# Curl, nmap, wireshark
function installCurl(){
	BLUE "\tInstalling curl..."
	sudo apt-get install -y curl
}
function installNmap(){
	BLUE "\tInstalling nmap..."
	sudo apt-get install -y nmap
}
function installWireshark(){
	BLUE "\tInstalling Wireshark..."
	sudo apt-get install -y wireshark
}
#################################################
############## Miscellaneous #####################
function installSpotify(){
	BLUE "\tInstalling Spotify ..."
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update -y && sudo apt-get install -y spotify-client
}
function installDiscord(){
	BLEU "\tInstalling Discord ..."
	wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
	sudo dpkg -i discord.deb
	rm discord.deb
}
function installObs(){
	BLEU "\tInstalling OBS ..."
	sudo apt install -y ffmpeg
	sudo add-apt-repository ppa:obsproject/obs-studio
	sudo apt update
	sudo apt install -y obs-studio
}
############### Script ##########################
#You need root priviledge to make these installations:
checkRootPriviledge

updateAndUpgradeRepos

YELLOW " ====== Utilities ====="
installBuildEssential
installGit
installMacchanger
installImageMagick
installTldr

YELLOW " ====== Text and Hex Editors ====="
installVim
installSublimeText
#installAtom
installBless
#installGummi

YELLOW " ====== Pyton related instalations ====="
installPythonTools

YELLOW " ===== Networking tools ======"
installCurl
installNmap
installWireshark

YELLOW " ===== Miscellaneous ====="
installSpotify
installDiscord
#installObs
