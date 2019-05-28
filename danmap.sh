#!/bin/bash

# An bash script implementation of nmap 
# created by Dan Hope on 5-28-19

# Target request menu
target_request(){
	normal=`echo "\033[m"`
	menu=`echo "\033[36m"` # Blue
	text=`echo "\033[33m"` # Yellow
	bgred=`echo "\033[41m"` # Red background
	fgred=`echo "\033[31m"` # Red foreground
	printf "\n${fgred}Welcome to danMap -- nmap for noobs\n"
	printf "${menu}***********************************************${normal}\n"
	printf "${menu}**${text} Please enter the IP address or${normal}\n"
	printf "${menu}**${text} domain you want to scan: ${fgred}"
	read target

}

# Create the initial menu
show_menu(){
	normal=`echo "\033[m"`
	menu=`echo "\033[36m"` # Blue
	number=`echo "\033[33m"` # Yellow
	bgred=`echo "\033[41m"` # Red background
	fgred=`echo "\033[31m"` # Red foreground
	printf "${menu}***********************************************${normal}\n"
	printf "${menu}**${number} 1) ${menu} Quick Scan${normal}\n"
	printf "${menu}**${number} 2) ${menu} Intense Scan${normal}\n"
	printf "${menu}**${number} 3) ${menu} Intense, all TCP ports${normal}\n"
	printf "${menu}**${number} 4) ${menu} Ping Scan${normal}\n"
	printf "${menu}**${number} 5) ${menu} Regular Scan${normal}\n"
	printf "${menu}***********************************************${normal}\n"
	printf "Please enter a menu option and press [ENTER] or ${fgred}x to exit. ${normal}"
	read opt
}

# Create choice feedback
option_picked(){
	msgcolor=`echo "\033[01;31m"` # Bold red
	normal=`echo "\033[00;00m"` # Normal white
	message=${@:-"${normal}Error: Not a valid entry"}
	printf "${msgcolor}${message}${normal}\n"
}

# Another scan?
another_scan(){
	normal=`echo "\033[m"`
	menu=`echo "\033[36m"` # Blue
	text=`echo "\033[33m"` # Yellow
	bgred=`echo "\033[31m"` # Red Foreground
	printf "\n${menu}***********************************************${normal}\n"
	printf "${menu}**${text}Would you like to run another scan? (y/n): ${normal}"
	read continue
	

	if [ $continue = 'y' ]
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
while [ $opt != '' ]
	do
	if [ $opt = '' ];
	then
		exit;
	else
		case $opt in
			1) clear;
				option_picked "Quick Scan chosen on ${target}";
				printf "nmap -T4 -F ${target}\n";
				nmap -T4 -F ${target};
				another_scan;
			;;
			2) clear;
				option_picked "Intense Scan on ${target}";
				printf "nmap -T4 -A -v ${target}\n";
				nmap -T4 -A -v ${target};
				show_menu;
			;;
			3) clear;
				option_picked "Intense Scan, all TCP ports on ${target}";
				printf "nmap -p 1-65535 -T4 -A -v ${target}\n";
				nmap -p 1-65535 -T4 -A -v ${target};
				show_menu;
			;;
			4) clear;
				option_picked "Ping Scan on ${target}";
				printf "nmap -sn ${target}\n";
				nmap -sn ${target};
				show_menu;
			;;
			5) clear;
				option_picked "Regular Scan on ${target}";
				printf "nmap ${target}\n";
				nmap ${target};
				show_menu;
			;;
			x) printf "Thanks for using danMap!\n\n";
				exit;
			;;
			*) clear;
				option_picked "Pick an option from the menu";
				show_menu;
			;;
		esac
	fi
done