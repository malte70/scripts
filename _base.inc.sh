#!/bin/sh
# 
# _base.inc.sh
#    Part of: malte70's Shell scripts <https://github.com/malte70/scripts>
# 
# Basic features for my shell scripts
# 
# Copyright (c) 2015 Malte Bublitz, http://malte-bublitz.de
# All rights reserved.
# 

_ANSI_ESCAPE=$(printf "\e")
_ANSI_RESET="${_ANSI_ESCAPE}[0m"
_ANSI_ATTR_BOLD="${_ANSI_ESCAPE}[1m"
_ANSI_ATTR_ITALIC="${_ANSI_ESCAPE}[3m"
_ANSI_ATTR_UNDERLINE="${_ANSI_ESCAPE}4m"
_ANSI_COLOR_BLACK="${_ANSI_ESCAPE}[0;30m"
_ANSI_COLOR_RED="${_ANSI_ESCAPE}[0;31m"
_ANSI_COLOR_GREEN="${_ANSI_ESCAPE}[0;32m"
_ANSI_COLOR_YELLOW="${_ANSI_ESCAPE}[0;33m"
_ANSI_COLOR_BLUE="${_ANSI_ESCAPE}[0;34m"
_ANSI_COLOR_DARK_MAGENTA="${_ANSI_ESCAPE}[0;35m"
_ANSI_COLOR_DARK_CYAN="${_ANSI_ESCAPE}[0;36m"
_ANSI_COLOR_GREY="${_ANSI_ESCAPE}[0;37m"
_ANSI_COLOR_DARK_GREY="${_ANSI_ESCAPE}[1;30m"
_ANSI_COLOR_LIGHT_RED="${_ANSI_ESCAPE}[1;31m"
_ANSI_COLOR_LIGHT_GREEN="${_ANSI_ESCAPE}[1;32m"
_ANSI_COLOR_LIGHT_YELLOW="${_ANSI_ESCAPE}[1;33m"
_ANSI_COLOR_LIGHT_BLUE="${_ANSI_ESCAPE}[1;34m"
_ANSI_COLOR_MAGENTA="${_ANSI_ESCAPE}[1;35m"
_ANSI_COLOR_CYAN="${_ANSI_ESCAPE}[1;36m"
_ANSI_COLOR_WHITE="${_ANSI_ESCAPE}[1;37m"

_print() {
	printf "$@"
}
_println() {
	printf "$@"
	echo
}
_print_term() {
	if [[ $TERM != "dump" ]]; then
		_print $@
	fi
}
_println_term() {
	if [[ $TERM != "dump" ]]; then
		_println $@
	fi
}

message() {
	_print_term $_ANSI_COLOR_GREEN
	_print "[${SCRIPT_NAME}] "
	_print_term $_ANSI_RESET
	_println $@
}
message_error() {
	(
		_print_term $_ANSI_COLOR_RED
		_print "[${SCRIPT_NAME}] Error: "
		_print_term $_ANSI_RESET
		_println $@
	) >&2
}
message_debug() {
	(
		_print_term $_ANSI_COLOR_YELLOW
		_print "[${SCRIPT_NAME}] [DEBUG] "
		_print_term $_ANSI_RESET
		_println $@
	) >&2
}

version() {
	echo "$SCRIPT_NAME $SCRIPT_VERSION"
}

# 
# OS detection
# 

OS=`uname -s`
OSVERSION=`uname -r`
if [[ "$OS" == "Darwin" ]]; then
	OS="Mac OS X"
	OSVARIANT=$OS
	OSXVersion=`python -c 'import platform; print platform.mac_ver()[0],'`
	OSVERSION=$OSXVersion
elif [[ `uname -o` == "Cygwin" ]]; then
	OS="Windows NT"
	OSVERSION=`python -c 'import OSDetect; _i = OSDetect.OSInfo(); print _i.GetInfo()["OSVersion"]'`
else
	OS=`uname -o`
	if which lsb_release &>/dev/null; then
		OSVARIANT=`lsb_release -s -i`
	else
		OSVARIANT=$OS
	fi
	OSVERSION=`uname -r`
fi

# 
# Set $EDITOR if not already set, so the scripts can expect it usable
# 
if [[ -z $EDITOR ]]; then
	if ! which vim &>/dev/null; then
		if ! which nano &>/dev/null; then
			if ! which vi &>/dev/null; then
				message_error "Neither vim, nor vi, nor nano found!"
				exit 1
			else
				EDITOR="vi"
			fi
		else
			EDITOR="nano"
		fi
	else
		EDITOR="vim"
	fi
fi


if [[ "$1" == "--version" || "$1" == "-V" ]]; then
	version
	exit 0
fi

