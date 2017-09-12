#!/bin/bash

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

#Search Directory for String "copy"
rm -i $1/*\(copy\)*

exit 0