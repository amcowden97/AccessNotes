#!/bin/bash

#This script is a tool to simply renamefiles
#found within a directory and subdirectory and make all the spaces
#or dashes replaced with underscore characters as well as enforce other semantics described below


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

#Get Number of Files in Directory
file_count=$(ls -afq | wc -l)
((file_count=file_count-2))

#Store Number of Files Completed
completed_count=0

#Renaming For Loop
for file in ${1}/*; do
	
	#I have each of the following in steps to improve readability
	#The same effect can be done in a smaller number of lines if desirable
	#List of Operations Done
	#	1. All Lowercase Characters
	#	2. Convert All Spaces and Dashes to Underscores
	#	3. Remove Trailing White Space Before or After Extension
	
	#Remove Extension
	pathless_name="$(basename "$file")"
	file_name="${pathless_name%.*}"
	extension="${file##*.}"
	
	#Convert to Title Case with Apostrophe Capabilites
	lower_case=$(echo "$file_name" | sed 's/\(.*\)/\L\1/')
		
	#Replace Spaces and Dashes with Underscores
	remove_spaces=$(echo $lower_case | sed -e 's/[\ \-]/\_/g' -e 's/\_\./\./g')
	
	#New Filename Format Selector
	case "$pathless_name" in
	*\.*)
		new_file="${1}/$remove_spaces.$extension"	#Contains Extension
		;;
	*)
		new_file="${1}/$remove_spaces"				#Does not Contain Extension
		;;
	esac
	
	#Rename Files
	if [ ! -a "$new_file" ] && [ "$file" != "$new_file" ]; then
		if [ -d "$file" ]; then				#Directory Call
			mv "$file" "$new_file" 
		elif [ -f "$file" ]; then			#Regualar File Call
			mv "$file" "$new_file"
		fi
	fi
	
	#Progress Bar Calculation and Display
	((completed_count=completed_count+1))
	percent_float=$(echo "$completed_count / $file_count * 100" | bc -l)
	percent=$(echo "$percent_float / 1" | bc)
	
	
done

exit 0


