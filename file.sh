#!/bin/bash
trap 'tput cnorm; clear; exit 0' INT TERM
tput civis
shopt -s nullglob
array=( * )
shopt -u nullglob
up_down=0
show_file_command()
{
	printf "\e[H\e[J"
	less "${array[$up_down]}"
	
}
help_command()
{
	printf "\e[H\e[J"
	echo -e "
███████╗██╗██╗     ███████╗    ███╗   ███╗ █████╗ ███╗   ██╗ █████╗  ██████╗ ███████╗██████╗ 
██╔════╝██║██║     ██╔════╝    ████╗ ████║██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔════╝██╔══██╗
█████╗  ██║██║     █████╗      ██╔████╔██║███████║██╔██╗ ██║███████║██║  ███╗█████╗  ██████╔╝
██╔══╝  ██║██║     ██╔══╝      ██║╚██╔╝██║██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══╝  ██╔══██╗
██║     ██║███████╗███████╗    ██║ ╚═╝ ██║██║  ██║██║ ╚████║██║  ██║╚██████╔╝███████╗██║  ██║
╚═╝     ╚═╝╚══════╝╚══════╝    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝

USER GUIDE
ABOUT
This is a simple file manager for the terminal.
It is written from scratch in Bash.
You can use it to move through folders and view basic information
about the selected item.

CURRENT FEATURES
  - Show files and folders in the current location
  - Move the selection up and down
  - Open a selected folder
  - Go back to the parent folder
  - View basic information about the selected item, such as its type
    and permissions
  - Use the keyboard without typing full commands

KEYS :
 | Up Arrow       Move the selection up    |
 | Down Arrow     Move the selection down  |
 | Enter          Open the selected folder |
 | Enter          Cat the selected file    |
 | Backspace      Go to the parent folder  |
 | h              Show this help page      |
 | q              Quit the file manager    |
 | x              Show hidden file once    |
"
	read -srp "Press Enter to return to the file manager : "
}
permission_file()
{
	if [ -r "$1" ];then 
		local r="-r"
	else
		local r="-*"
	fi
	if [ -w "$1" ];then
		local w="-w"
	else
		local w="-*"
	fi
	if [ -x "$1" ];then
		local x="-x"
	else
		local x="-*"
	fi
	if [ -f "$1" ];then
		echo "| permissions : $r$w$x |"
	elif [ -d "$1" ];then
		echo "| permissions : $r$w$x |"
	fi

}
color_function()
{
	local file="$1"
	local extra="$2"
	local color="\e[0m"

	if [ -d "$file" ]; then
		color="\e[1;92m"  
	elif [ -f "$file" ]; then
		color="\e[1;94m"  
	fi
	if [[ "$file" == .* ]]; then
		color="\e[1;91m"
	fi

	echo -e "${color}${file}${extra}\e[0m"
}

while true
do	
	printf "\e[H\e[J"

	for n in "${!array[@]}"
	do
		if [[ $n -eq $up_down ]]; then
			x=$(permission_file "${array[$up_down]}")
			y=$(color_function "${array[$up_down]}" " : $x")
			echo -e "[#] $y"
		else
			y=$(color_function "${array[$n]}")
			echo -e "[-] $y"
		fi
	done


	read -srn1 key
	if [[ "$key" == $'\e' ]];then
		read -srn2 key
		case "$key" in
			"[A")
				if [[ $up_down -gt 0 ]];then
					((up_down-=1))
				fi
				;;
			"[B")
				if [[ $up_down -lt $((${#array[@]} -1)) ]];then
					((up_down+=1))
				fi
				;;
		esac
	fi
	case "${key,,}" in
		"q")
			clear
			tput cnorm 
			exit 0
			;;
		"")
			if [ -d "${array[$up_down]}" ];then 
				if cd "${array[$up_down]}" 2>/dev/null;then 
					shopt -s nullglob;array=( * )
					shopt -u nullglob
					up_down=0
					fi
			elif [ -f "${array[$up_down]}" ];then
				show_file_command
				fi
			;;
		$'\x7f' | $'\x08')
			cd ..;shopt -s nullglob;array=( * );shopt -u nullglob;up_down=0
			;;
		"h")
			help_command
			;;
		'x')
			shopt -s dotglob;array=( * );shopt -u dotglob
			;;
		
	esac

done
