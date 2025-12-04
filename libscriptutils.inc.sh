# vim: set ft=bash:
# 
# _base.inc.sh
#    Part of: malte70's Shell scripts <https://github.com/malte70/scripts>
# 
# Basic features for my shell scripts
# 
# Usage:
#     - Set $SCRIPT_NAME and $SCRIPT_VERSION
#     - `source` this file
# 


##########################################
# ANSI Escape Codes
# 

# 
# The ESC character (U+001B)
# 
_ANSI_ESCAPE=$(printf "\e")

# 
# Reset all formatting
# 
_ANSI_RESET="${_ANSI_ESCAPE}[0m"

# 
# (Classic) Attributes and their reset codes
# 
_ANSI_ATTR_BOLD="${_ANSI_ESCAPE}[1m"
_ANSI_ATTR_BOLD_RESET="${_ANSI_ESCAPE}[21m"
_ANSI_ATTR_ITALIC="${_ANSI_ESCAPE}[3m"
_ANSI_ATTR_ITALIC_RESET="${_ANSI_ESCAPE}[23m"
_ANSI_ATTR_UNDERLINE="${_ANSI_ESCAPE}[4m"
_ANSI_ATTR_UNDERLINE_RESET="${_ANSI_ESCAPE}[24m"
_ANSI_ATTR_STRIKETHROUGH="${_ANSI_ESCAPE}[9m"
_ANSI_ATTR_STRIKETHROUGH_RESET="${_ANSI_ESCAPE}[29m"
# Switch foreground<->Background colors
_ANSI_ATTR_INVERSE="${_ANSI_ESCAPE}[7m"
_ANSI_ATTR_INVERSE_RESET="${_ANSI_ESCAPE}[27m"
# Annoying, but included for the sake of completeness
_ANSI_ATTR_BLINKING="${_ANSI_ESCAPE}[5m"
_ANSI_ATTR_BLINKING_RESET="${_ANSI_ESCAPE}[25m"
# Like _ANSI_ATTR_BLINKING; I don't even know any practical use for this…
_ANSI_ATTR_HIDDEN="${_ANSI_ESCAPE}[8m"
_ANSI_ATTR_HIDDEN_RESET="${_ANSI_ESCAPE}[28m"

# 
# Advanced "attributes"/functionality
# WARNING: No detection if the terminal supports these!
# 
# - ESC[?25h    make cursor visible
# - ESC[?25l    make cursor invisible
# - ESC[?47h    save screen
# - ESC[?47l    restore screen
# - ESC[?1049h  enables the alternative buffer
# - ESC[?1049l  disables the alternative buffer
# 
_ANSI_ATTR_CURSOR_VISIBLE="${_ANSI_ESCAPE}[?25h"
_ANSI_ATTR_CURSOR_HIDDEN="${_ANSI_ESCAPE}[?25l"
_ANSI_ATTR_SCREEN_SAVE="${_ANSI_ESCAPE}[?47h"
_ANSI_ATTR_SCREEN_RESTORE="${_ANSI_ESCAPE}[?47l"
_ANSI_ATTR_ALTERNATE_BUFFER_ENABLED="${_ANSI_ESCAPE}[?1049h"
_ANSI_ATTR_ALTERNATE_BUFFER_DISABLED="${_ANSI_ESCAPE}[?1049l"

# 
# Colors (original 16 colors)
# 
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



##########################################
# Functions
# 

# 
# For internal use
# 
# Write to stdout and support escape-codes
_print() {
	#printf "$@"
	echo -en "$@"
}
# Like _print, but add a newline
_println() {
	#printf "$@"
	#echo
	echo -e "$@"
}
# Write only to a real terminal
_print_term() {
	if [[ $TERM != "dump" ]]; then
		_print "$@"
	fi
}
# _print_term with a leading newline
_println_term() {
	if [[ $TERM != "dump" ]]; then
		_println "$@"
	fi
}

# 
# Functions for use in scripts
# 
# A regular message
message() {
	_print_term $_ANSI_COLOR_GREEN
	_print "[${SCRIPT_NAME}] "
	_print_term $_ANSI_RESET
	_println "$@"
}
# An error message (on stderr)
message_error() {
	(
		_print_term $_ANSI_COLOR_RED
		_print "[${SCRIPT_NAME}] Error: "
		_print_term $_ANSI_RESET
		_println "$@"
	) >&2
}
# A message with additional information (INFO level, on stderr)
message_info() {
	(
		_print_term $_ANSI_COLOR_YELLOW
		_print "[${SCRIPT_NAME}] [INFO] "
		_print_term $_ANSI_RESET
		_println "$@"
	) >&2
}
# Detailed information for debugging purpose on stderr,
# only shown if $DEBUG equals 1
message_debug() {
	if [[ $DEBUG -eq 1 ]]; then
		(
			_print_term $_ANSI_COLOR_YELLOW
			_print "[${SCRIPT_NAME}] [DEBUG] "
			_print_term $_ANSI_RESET
			_println "$@"
		) >&2
	fi
}

# Support "--version"/"-V" options by default
# See also the if statement at the end of this file,
# which checks if one of the options where passed.
version() {
	echo "$SCRIPT_NAME $SCRIPT_VERSION"
}



##########################################
# OS detection and $HOST for bash
# 

OS=`uname -s`
OSVERSION=`uname -r`
if [[ "$OS" == "Darwin" ]]; then
	OS="Mac OS X"
	OSVARIANT=$OS
	OSXVersion=`python3 -c 'import platform;print(platform.mac_ver()[0],end="")'`
	OSVERSION=$OSXVersion
elif [[ `uname -o` == "Cygwin" ]]; then
	OS="Windows NT"
	OSVERSION=`python -c 'import OSDetect; _i = OSDetect.OSInfo(); print _i.GetInfo()["OSVersion"]'`
else
	OS=`uname -o`
	if [[ -e /etc/os-release ]]; then
		OSVARIANT=`grep ^NAME= /etc/os-release | cut -d= -f2 | tr -d \"`
	elif which lsb_release &>/dev/null; then
		OSVARIANT=`lsb_release -s -i`
	else
		OSVARIANT=$OS
	fi
	OSVERSION=`uname -r`
fi
#if [[ -n $BASH_VERSION ]]; then
if [[ -n $HOST ]]; then
	export HOST=$HOSTNAME
fi
IS_ZSH=0
IS_BASH=0
if [[ -n $ZSH_NAME ]]; then
	IS_ZSH=1
elif [[ -n $BASH_VERSION ]]; then
	IS_BASH=1
fi



##########################################
# Ensure $EDITOR is set and usable
# 

if [[ -z $EDITOR ]]; then
	if [ -x /etc/alternatives/editor ]; then
		EDITOR="editor"
	elif which vim &>/dev/null; then
		EDITOR="vim"
	elif which nano &>/dev/null; then
		EDITOR="nano"
	elif which vi &>/dev/null; then
		EDITOR="vi"
	else
		message_error "Neither vim, nor vi, nor nano found!"
		exit 1
	fi
fi



##########################################
# Change terminal title
# https://tldp.org/HOWTO/pdf/Xterm-Title.pdf
# 

if [[ $IS_ZSH == 1 ]]
then
	set-xterm-title() {
		[[ "$TERM" == *xterm* ]] \
			&& print -Pn "\e]0;$1\a"
	}
	
elif [[ $IS_BASH == 1 ]]; then
	set-xterm-title() {
		[[ "$TERM" == *xterm* ]] \
			&& printf "\033]0;%s\007" "$@"
	}
	
else
	set-xterm-title() {
		false
	}
fi



##########################################
# Support for "--version"/"-V" options
# 

if [[ "$1" == "--version" || "$1" == "-V" ]]; then
	version
	exit 0
fi

