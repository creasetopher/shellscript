#!/bin/bash
# Problem: Often I create a file and save it for future reference/access. Sometimes, although I remember creating
#	 the file, I unintentionally save it in a parent directory instead of the
#	 sub-directory I'm currently working in.
#	 To address this issue, I have to `cd ../../..` then `ls` to search for the file.
# Name of commands: cd, ls
# Example of its usage:
#	-bash-4.2$ cd ../.. -> takes user two directories up.
#	-bash-4.2$ ls
#	CS5004/CS5005	CS5006	CS5007

# Here is a script myScript.sh that can take a file or directory name to search all parent folders
# for existence. If the file does not exist, the script will create it in the current directory.
# usage 1:
#	In this example, there is a file named "file.txt" in the folder /Users/chrissims/Documents.
#
#	Run the script with command
#		sh myScript.sh
#		>> Enter a filename or directory name: file.txt
#		>> This file is in: /Users/chrissims/Documents
#
# usage 2:
#	In this example, a user is looking for a file named "grappling.c" which does
#	not exist on the users machine. The script will look in the current folder and move its way
#	up the file tree looking for the file until it reaches the user's home directory. If the script has does not find the
#	file, it will ask the user if they'd like to create the file in the current working directory.
#
#	Run the script with command 
#		sh myScript.sh
#       	>> Enter a filename or directory name: grappling.c
#		>> "grappling.c" was not found in any of the parent folders.
#       	>> Would you like to create "grappling.c" in <current working directory>? (y/n)" Y
#		>> File 'grappling.c' created!


CURR_DIR=$(pwd)
HOME_DIR=$HOME

current_dir=$(pwd)
isfound=false

echo "Enter a filename (with extension) or directory name: "
read some_file

while [ $current_dir != $HOME_DIR ]
do
	files=$current_dir"/*"
	for file in $files
		do
		if [ $(basename $file) == $some_file ];
		then 
			echo "The file $some_file is in $current_dir"
			isfound=true
			break
		fi		
	done
	cd ..
	current_dir=$(pwd)

	if $isfound;
        then
       	 	break
	fi
done

if ! $isfound;
then
	echo "$some_file was not found in any of the parent folders."
	echo "Would you like to create $some_file in $CURR_DIR? (y/n)"
	read response
	if [[ ( $response == "y" || $response == "Y" ) ]];
	then
	cd $CURR_DIR
	touch $some_file
	echo "File $some_file created!"
	fi
fi
