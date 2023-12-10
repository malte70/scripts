#!/usr/bin/env zsh

APP_NAME=$(basename $0)
APP_VERSION="0.20231127"

D1MINI_HOST="d1mini"
TEMPERATURE_URL="http://${D1MINI_HOST}/temp"
TEMPERATURE_WARN=27
#TEMPERATURE_WARN=20
#export PUSHOVER_APP_ID="gallifrey"
export PUSHOVER_APP_ID="raspberrypi"
export PUSHOVER_PRIORITY=1

source $(dirname $0)/_base.inc.sh

usage() {
	echo "Usage:"
	echo "  $SCRIPT_NAME [--help|--version]"
	echo
}

while [[ $# -gt 0 ]]; do
	if [[ "$1" == "--help" || "$1" == "-h" ]]; then
		# Run usage() to display a help text and immediately exit
		usage
		exit 0
		
	elif [[ "$1" == "--version" || "$1" == "-V" ]]; then
		# Like "--help", immediately display information and exit
		version
		exit 0
		
	else
		message_error "Unknown option: $1"
	fi
	shift
	
done

_temp=$(curl -s -o- ${TEMPERATURE_URL})

if [[ $_temp -ge ${TEMPERATURE_WARN} ]]; then
	echo "The temperature is currently $_temp°C, which is over the threshold of ${TEMPERATURE_WARN}°C" \
		| pushover-notify "Temperature $_temp°C (Threshold: ${TEMPERATURE_WARN}°C)"
	echo "ESP8266 + RPi
Temperature: $_temp!" | ssh mcp /Users/malte70/code/mapid/notification.sh
fi
