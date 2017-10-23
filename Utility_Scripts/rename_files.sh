#!/bin/bash

#This script is a tool to simply rename regular files
#found within a directory and subdirectory and make all the spaces
#or dashes replaced with underscore characters


#Error Constants
INVAL_ARG=55
INVAL_DIR=56

#Error Function Handler
function error_function {
	case $1 in
		"$INVAL_ARG")
			echo "Invalid Number of Arguments... Usage $0 directory"
		;;
		"$INVAL_DIR")
			echo "The Argument Given is not a Directory... Usage $0 directory"
		;;
	esac
	
	exit $1
}

#Argument Number Handler
if [ $# -gt 1 ] || [ $# -lt 1 ]; then
	error_function $INVAL_ARG
fi

#Directory Argument Handler
if [ ! -d "$1" ]; then

	error_function $INVAL_DIR
fi

#Renaming For Loop
for file in ${1}/*; do
	
	#I have each of the following in steps to improve readability
	#The same effect can be done in a smaller number of lines if desirable
	#List of Operations Done
	#	1. All Lowercase But the Leading Letter of Each Word
	#	2. Convert All Spaces and Dashes to Underscores
	#	3. Remove Trailing White Space Before or After Extension
	
	#Remove Extension
	pathless_name="$(basename "$file")"
	file_name="${pathless_name%.*}"
	extension="${file##*.}"

	#Convert All to Lowercase
	lowercase=$(echo "$file_name" | sed 's/\(.*\)/\L\1/')
	
	#Capitalize the first letter of Each word
	capital_words=$(echo $lowercase | sed -e 's/\b\(.\)/\u\1/g' -e 's/[^ _-]*/\u&/g')
	
	#Replace Spaces and Dashes with Underscores
	remove_spaces=$(echo $capital_words | sed -e 's/[\ \-]/\_/g' -e 's/\_\./\./g')
	
	#New Filename Format
	new_file=${1}/$remove_spaces.$extension


	if [ ! -a "$new_file" ] && [ "$file" != "$new_file" ]; then
		if [ -d "$file" ]; then				#Directory Call
			mv "$file" $new_file 
		elif [ -f "$file" ]; then			#Regualar File Call
			mv "$file" $new_file
		fi
	fi
done

exit 0


