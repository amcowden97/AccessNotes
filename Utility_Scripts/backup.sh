#!/bin/bash

#Error Constants
INVAL_ARG=55
INVAL_DIR=56

#Error Function Handler
function error_function {
	case $1 in
		"$INVAL_ARG")
			echo "Invalid Number of Arguments... Usage $0 sourcedirectory destdirectory"
		;;
		"$INVAL_DIR")
			echo "The Argument Given is not a Directory... Usage $0 sourcedirectory destdirectory"
		;;
	esac
	
	exit $1
}

#Argument Number Handler
if [ $# -gt 2 ] || [ $# -lt 2 ]; then
	error_function $INVAL_ARG
fi

#Directory Argument Handler
if [ ! -d "$1" ] && [ ! -d "$2" ]; then
	error_function $INVAL_DIR
fi

#Copying File
for file in ${1}/*; do
	file_name="$(basename "$file")".bak
	echo "Writing " $file_name " to " $2
done

exit 0