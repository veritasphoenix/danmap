#!/bin/bash

# An bash script implementation of nmap 
# created by Dan Hope on 5-28-19

# Colors
NORMAL=$("\033[m")
MENU=$("\033[36m") # Blue
TEXT=$("\033[33m") # Yellow
NUMBER=$("\033[33m") # Yellow
MSGCOLOR=$("\033[01;31m") # Bold red
BGRED=$("\033[41m") # Red background
FGRED=$("\033[31m") # Red foreground

# Target request menu
target_request(){
	printf "\n${FGRED}Welcome to danMap -- nmap for noobs\n"
	printf "${MENU}***********************************************${NORMAL}\n"
	printf "${MENU}**${TEXT} Please enter the IP address or${NORMAL}\n"
	printf "${MENU}**${TEXT} domain you want to scan: ${FGRED}"
	read TARGET
}

# Create the initial MENU
show_menu(){
	printf "${MENU}***********************************************${NORMAL}\n"
	printf "${MENU}**${NUMBER} 1) ${MENU} Quick Scan${NORMAL}\n"
	printf "${MENU}**${NUMBER} 2) ${MENU} Intense Scan${NORMAL}\n"
	printf "${MENU}**${NUMBER} 3) ${MENU} Intense, all TCP ports${NORMAL}\n"
	printf "${MENU}**${NUMBER} 4) ${MENU} Ping Scan${NORMAL}\n"
	printf "${MENU}**${NUMBER} 5) ${MENU} Regular Scan${NORMAL}\n"
	printf "${MENU}***********************************************${NORMAL}\n"
	printf "Please enter a menu option and press [ENTER] or ${FGRED}x to exit. ${NORMAL}"
	read OPT
}

# Create choice feedback
option_picked(){
	MESSAGE=${@:-"${NORMAL}Error: Not a valid entry"}
	printf "${MSGCOLOR}${MESSAGE}${NORMAL}\n"
}

# Another scan?
another_scan(){
	printf "\n${MENU}***********************************************${NORMAL}\n"
	printf "${MENU}**${TEXT}Would you like to run another scan? (y/n): ${NORMAL}"
	read CONTINUE
	
	if [ $CONTINUE = 'y' ]
	then
		target_request;
	else
		printf "Thanks for using danMap!\n\n";
		exit;
	fi
}

clear
target_request
show_menu
while [ $OPT != '' ]
	do
	if [ $OPT = '' ];
	then
		exit;
	else
		case $OPT in
			1) clear;
				option_picked "Quick Scan chosen on ${TARGET}";
				printf "nmap -T4 -F ${TARGET}\n";
				nmap -T4 -F ${TARGET};
				another_scan;
			;;
			2) clear;
				option_picked "Intense Scan on ${TARGET}";
				printf "nmap -T4 -A -v ${TARGET}\n";
				nmap -T4 -A -v ${TARGET};
				show_menu;
			;;
			3) clear;
				option_picked "Intense Scan, all TCP ports on ${TARGET}";
				printf "nmap -p 1-65535 -T4 -A -v ${TARGET}\n";
				nmap -p 1-65535 -T4 -A -v ${TARGET};
				show_menu;
			;;
			4) clear;
				option_picked "Ping Scan on ${TARGET}";
				printf "nmap -sn ${TARGET}\n";
				nmap -sn ${TARGET};
				show_menu;
			;;
			5) clear;
				option_picked "Regular Scan on ${TARGET}";
				printf "nmap ${TARGET}\n";
				nmap ${TARGET};
				show_menu;
			;;
			x) printf "Thanks for using danMap!\n\n";
				exit;
			;;
			*) clear;
				option_picked "Pick an option from the MENU";
				show_menu;
			;;
		esac
	fi
done