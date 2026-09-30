#!/bin/bash
shopt -s nullglob
array=( * )
shopt -u nullglob
up_down=0
help_command()
{
	clear
	echo -e "
FILE MANAGER
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

KEYS
  Up Arrow       Move the selection up
  Down Arrow     Move the selection down
  Enter          Open the selected folder
  Backspace      Go to the parent folder
  h              Show this help page
  q              Quit the file manager

HOW TO USE
  1. Use the Up and Down Arrow keys to choose an item.
  2. Press Enter to open a folder.
  3. Press Backspace to return to the parent folder.
  4. Press h to read this help page.
  5. Press q to quit.

PLANNED IDEAS
The features below are ideas for future versions.
They are not available unless they have been added to the program.

  - Open a text file and show its contents
  - Rename a file or folder
  - Copy or move files
  - Delete files and folders with a confirmation message
  - Create a new file or folder
  - Search for files by name
  - Show or hide hidden files
  - Sort items by name, size, or date
  - Show file size and last change time
  - Open a file with the system's default program
  - Ask for confirmation before actions that may remove data

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
		local format=${1##*.}
		echo "| permissions : $r$w$x | $format file | "
	elif [ -d "$1" ];then
		echo "| permissions : $r$w$x | directory |"
	fi

}

while true
do	
	clear

	for n in "${!array[@]}"
	do
		if [[ $n -eq $up_down ]];then
			x=$(permission_file "${array[$up_down]}")
			echo "[*] "${array[$up_down]}" : $x"
		else
			echo "[-] ${array[$n]}"
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
	if [ "$key" == "q" ];then
		clear
		exit 0
	fi		
	if [[ "$key" == "" ]];then
		if [ -d "${array[$up_down]}" ];then
			if cd "${array[$up_down]}" 2>/dev/null; then
    			shopt -s nullglob
    			array=( * )
    			shopt -u nullglob
    			up_down=0
			fi

		fi
	fi
	if [[ "$key" == $'\x7f' ]];then

		cd ..
		shopt -s nullglob
		array=(*)
		shopt -u nullglob
		up_down=0
	fi
	if [[ "$key" == "h" ]];then help_command;fi
done
