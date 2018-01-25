#!/bin/bash

#This Script acts as a tool to quickly setup this computer for viewing
#media using another audio output devive. The options allow for HDMI
#output or the standard PC computer speakers / internal laptop speakers.

#NOTE: If you are recieving an error while performing this script, please
#run the command pactl list short sinks and see what your internal and
#HDMI audio connections are listed as and change the corresponding grep 
#calls below.

#Error Constants
INVAL_ARG=55
INVAL_SOURCE=56

#Error Function Handler
function error_function {
	case $1 in
		"$INVAL_ARG")
			echo "Invalid Arguments... Usage $0 [hdmi / internal]"
		;;
		"$INVAL_SOURCE")
			echo "The Argument Given is not a Directory... Usage $0 directory"
		;;
	esac
	
	exit $1
}

#Argument Number Handler
if [ $# -gt 1 ] || [ $# -lt 1 ]; then
	error_function $INVAL_ARG
fi

#Desired Sink To Switch Audio To
user_sink=

#Input Validation
if [ $1 == "hdmi" ]; then
	user_sink=$(pactl list short sinks | grep hdmi | cut -f1)
	if [ -z "$user_sink" ]; then
		error_function $INVAL_SOURCE
	fi
	echo "Switching Audio Channels to HDMI Output..."
elif [ $1 == "internal" ]; then
	user_sink=$(pactl list short sinks | grep analog | cut -f1)
	if [ -z "$user_sink" ]; then
		error_function $INVAL_SOURCE
	fi
	echo "Switching Audio Channels to PC Internal Output..."
else
	error_function $INVAL_ARG
fi

#Set Volume to Zero Count Down
echo
for counter in {5..0}
do
	echo -en "\e[1A"
	echo -e "\e[0K\rSetting Volume To Zero In $counter s" 
	sleep 1
done
amixer -D pulse sset Master 0% &> /dev/null

#Build Up Count Down
echo
for counter in {5..0}
do
	echo -en "\e[1A"
	echo -e "\e[0K\rSetting Volume Build Up In $counter s" 
	sleep 1
done




exit 0

	