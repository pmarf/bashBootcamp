#!/usr/bin/bash
# oder allgemeiner
#!/bin/env bash
#
# bash programming bootcamp
#
# Copyright (c) 2026 https://github.com/pmarf
#
# References
#
# - GNU bash manual: https://www.gnu.org/software/bash/manual/
# - Bash beginners guide: https://tldp.org/LDP/Bash-Beginners-Guide/Bash-Beginners-Guide.pdf
# - Advanced scripting guide: https://tldp.org/LDP/abs/html/
# - Deutsch: www-user.tu-chemnitz.de/~hot/unix_linux_werkzeugkasten/bash.html
# - Bash Scripting Exercises and Solutions: https://www.w3resource.com/bash-script-exercises/index.php
# - man bash
# - man bash-builtin
#
# - Help
#   For most commands there exists direct help with "man <command>", for example "man ls"
#   In addition "help <builtin command>" wie z.B. for example "help echo", "help printf", "help export"
#
#   Any web search engine will help. In addition any KI like chatGPT

###########################################################################################
#
# ### Navigation and bash basics ###
#
###########################################################################################

if [[ "$*" =~ topics|all ]]; then
	echo
	echo ">>> bash bootcamp topics <<<"
	echo
	grep -E '# >>> .+ <<<' $0 | grep -v "grep"
	echo
fi

if [[ "$1" =~ \-([?h]|\-help) ]]; then
	echo "$0: [topics|homework|all]"
	exit
fi
if (( $# > 0 )); then
	exit 0
fi

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> History <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Shells are the console environments in Unix that you find yourself in after logging in.
# They allow you to administer a system manually and programmatically.
#
# There are various shells
# - Bourne Shell (/bin/sh) from Bell Labs for Unix (proprietary)
# - GNU Bourne-Again Shell (bash), written by Brian Fox in 1987 for the GNU Project
#      as a free (GPL) extension of the Bourne Shell and is de facto 
#      the standard interactive shell on Linux
# - C-shell (csh) from the University of California (BSD license)
# - Korn Shell (ksh) from Bell Labs as an improvement on the Bourne Shell (proprietary)
# - Z-Shell (zsh) is a very powerful extension of the Bourne Shell (MIT License)
# - Dash (Debian-Almquist-shell) is smaller and faster than bash but not as powerful
#      Often used as a non-interactive shell (BSD License)

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Comments <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Comments begin with # anywhere in the line. Everything that follows is ignored
# Line continuation using \ as the last character in a line

echo "This is a\
         demo of line continuation using many spaces"

# There are no block comments, but there is a workaround using a here doc

:<<SKIP
This is some text
that spans multiple lines
SKIP

# : is in bash a noop which returns true all the time

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Keyboard quickies <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# <TAB> expands filenames as far as possible and display all other files starting with the entered string
# <CTRL R> text, search in bash history for any command with the given text
# <ARROW UP/DOWN> retrieve previous and next command in history

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Directories <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# FSH - file system hierarchy

/bin - Binary files/commands
/dev - Device files
/etc - System configuration files
/lib - Libraries
/media - Mount point for removable media
/mnt - Temporarily mounted file system
/opt - Application programs
/sbin - System binaries
/tmp - Temporary files
/home - Home directory for all user directories
/root - Root directory

# A directory tree consists of names separated by /
# If / appears at the beginning, it is an absolute path. Without /, it is a relative path

# List all user directories
ls /home

# Use cd to change to a directory
# Use a ; to separate multiple commands
cd /home; ls -la
# or go up one directory
cd ..
# The home directory is ~ (tilde) and the current directory is . (period)
cd ~
ls -la .

# Creating a directory
mkdir Subdirectory1
mkdir Subdirectory2
mkdir Subdirectory3
# Deleting an empty directory
rmdir Subdirectory3
# Deleting a directory with contents
# rm -rf <directory>

# Directory and file permissions
# -rwxrwxr-x 1 peter peter 1484 Feb  2 17:36 bashBootcamp.sh
# 3 different access groups: Owner, Group, and Everyone
# 3 different permissions: Write (r), Read (r), and Execute (x)
# Owner and Group
# Size in bytes
# Modification date
# Name


ls -la bashBootcamp.sh
chmod +x bashBootcamp.sh # setzen des executebits

# >>> Globbing <<<
#
# Globbing refers to the expansion of wildcards using patterns before a command is executed
# * any character, ? exactly one character, [a-z] character class
# List all files in the current directory that begin with “bash”
# Be careful with special characters
# No globbing occurs when quotation marks are used
ls ./bash*
ls *.sh
ls sub[xv]directory
ls sub?directory
rmdir subdirectory1
rmdir subxdirectory2

# >>> Text splitting <<<

# Text is split according to the IFS separator. The default separators are space, tab, and LF
# If the string is enclosed in quotes, the text is not split
text="one two three"

echo "$text"
for word in $text; do
  echo "$word"
done
# Achtung !
for word in "$text"; do
  echo "$word"
done
# Does not split text—it is important to enclose variables in scripts within “ ... ”

# >>> Brace expansion

echo {file-1,file-2{a,b},file-3}
file-1 file-2a file-2b file-3

echo {a..e}
a b c d e
echo {10..1}
10 9 8 7 6 5 4 3 2 1
echo {a..c}{1..4} 
a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3 c4

mkdir /usr/local/src/{old,new,dist,bugs}
# creates /usr/local/old, /usr/local/new, /usr/local/dist und /usr/local/bugs

# >>> Sequence of substitutions

# 1. Brace expansion
# 2. Tilde expansion
# 3. Parameter & variable expansion ${...}, command substitution $( ... ), arithmetic expansion $(( ... ))
# 4. Word splitting
# 5. Filename expansion (globbing)
# 6. Quote removal

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Searchpathes <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Display the current search path
echo $PATH
# Bash environment settings
# The file ~/.bashrc is executed when the command window is opened
# and thus allows you to set up all sorts of things
# such as the path to always access a custom directory with shell scripts
# The colon is used to extend the search path with directories

# So first create a bin directory
mkdir ~/bin
# and then edit the ~/.bashrc file and
export PATH=$PATH:~/bin # add this to .bashrc
# Otherwise, you must always specify the full path or ./bashBootcamp.sh if the script is in the current directory

# Find where a script is located in the search path
which ./bashBootcamp.sh

# Output the CDPATH
echo $CDPATH
# Default is
#  export CDPATH=.
# Example extension in .bashrc
# export CDPATH=.:~/myProject

# Output all known exports
env

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Pipes <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Pipes allow command output to be passed to another command. This is common in Linux. This enables the creation of one-liners where multiple Linux tools are called sequentially
# The output of one command (stdout) becomes the input (stdin) for the following command. Error messages are written to stderr

ls ~ | grep -i boot*
# An alternative and better option
ls *Boot*

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Commonly used Linux commands <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# man <command> or <command> --help provides detailed information with all options

# cat - concatenate - concatenate files
# cp - copy files
# cut - select parts of a text line
# exec - execute commands without creating a subshell; instead, it replaces the current shell
# find - search for files or directories
# grep - Search for files with specific content
# head - Display the beginning of files
# less - Scrollable display of files
# locate - Search for files using the locatedb database
# ls - List file directories
# man - Display help text
# mv - Move files
# rename - Rename files
# rm - Delete files
# rsync - File synchronization
# script - Record a terminal session to a file
# sed - Non-interactive line editor
# sleep - Pause
# sort - Sort file contents
# sudo - Temporarily execute commands as root
# tail - Display the end of files
# tr - Transform characters
# tree - Recursively display directory structure
# wc - Count characters and lines
# xargs - Reads data from stdin and executes commands with these arguments

# Typical uses of pipes
# See also Unix philosophy (https://en.wikipedia.org/wiki/Unix_philosophy)

# Count how many comment lines there are in a file
grep “#>>>>>>>” ./bashBootcamp.sh | wc -l
# Count how many shell scripts there are
find -iname “*.sh” | wc -l
# Search all shell scripts for the text “if” but not “kniff” or similar
find -iname “*.sh” | xargs grep -H “\bif\b” | grep wc -lfind -iname “*.sh” | xargs grep -H “\bif\b” | grep wc -l

# or
find -iname “*.sh” -exec grep -H “\bif\b” ‘{}’ \; | wc -l

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Redirections <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Command input and output can be redirected. These are typically input and output files

# Output
# stdout (or 1) is the standard output channel; stderr (or 2) is the standard error channel
# With pipes, data is read from stdin and written to stdout
# > is a shorthand for 1>
ls > ls-file
# Input - counts the lines in a file
< bashBootcamp.sh wc -l
# Alternatively, and better
wc -l bashBootcamp.sh

# Redirect both stdout and stderr to a file
ls 1> ls-file 2>&1
# Caution: Do not reverse the order
ls 2>&1 1>ls-file
# Short form
ls &>ls-file

# Use exec to redirect both stderr and stdout to a file

exec 1>>logfile
exec 2>&1

# Or simply (both stdin and stderr are redirected)

exec &>>logfile

# Writing to a file
echo “Test” > file
# Appending to a file
echo “test” >> file

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Return Values of Tools <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# 0: Everything OK
# >0: Error; the specific reason is usually found in the man pages

# Handling return values

# Execute command2 only if command1 was successful
ls ~ && ls /

# Execute command2 if command1 was not successful
ls /dummy || ls ~

# Functions: return <0-255>
# Shell script: exit <0-255>

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Special bash variables - selection <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Current directory
echo “$PWD”
# Internal field separator (default: space, tab, and newline)
echo -n “$IFS” | xxd # Output in hex
# Search path
echo “$PATH”
# Command prompt string
echo “$PS1”
# Command-line arguments
echo “$1 $2 $3”
# Return value of the last script or function call
echo “$?”
# Number of command-line arguments for a script
echo “$#”
# Script and function arguments as a string
echo “$*”
# Script and function arguments as an array
echo “$@”

p() {
	echo "Args: $#"
	for e in "$*"; do
		echo '$*'": -$e-"
	done
	for e in "$@"; do
		echo '$@'": -$e-"
	done
}
p "one" "two" "three"
p "one two three"

###########################################################################################
#
# ### Programming ###
#
###########################################################################################

# - A good linter for Bash: shellcheck
#    sudo apt install shellcheck
#    https://github.com/koalaman/shellcheck/wiki/<shellcheckmessageid> provides a detailed description
#       of the message ID, why the message was generated, and how to fix it
#
# - Formatting tool
#   shfmt -i 3 *.sh (sudo apt install shfmt)

# Common editors:
# - vim (command line)
# - nano (command line)
# - geany (desktop) <== Recommended for beginners
# - emacs (desktop)
# - VS Code (IDE) (desktop)
# - mc (terminal UI)
# - ...

# Comments
# Characters on a separate line or after a command

# Scripts must be executable
chmod +x bashBootcamp.sh

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Variables <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Begin with $ on the right side and without $ on the left side, variables are always strings
# Use ${VARNAME} instead of $VARNAME whenever possible, except when performing calculations with numbers
VARIABLE1="Hello world"
VARIABLE2="${VARIABLE1}"
VARIABLE3=${VARIABLE1}
VARIABLE4="$VARIABLE1"

# Variable values should always be enclosed in " whenever possible
# - Protection against word splitting (IFS variable defines the splitting character; the default is a space, tab, or newline)

f() {
	echo "$1 - Parm#: $# Parms: $@"
}
f 1q "$VARIABLE1"
f 1  $VARIABLE1
f 2q "$VARIABLE2"
f 2  $VARIABLE2
f 3q "$VARIABLE3"
f 3  $VARIABLE3

# - Protection against globbing (wildcard substitution)
VARIABLE1="*"
echo ${VARIABLE1} # does not output * but rather the files in the current directory
echo “${VARIABLE1}” # outputs * because globbing does not occur

# Indirekt adressierung by name

declare -n ref=PTR
V1="VAR1"
PTR="V1"
echo "$PTR"
V2="VAR2"
PTR="V2"
echo "$PTR"

# Variable types
# - Regular variable: V=10 or v="one"
# - List: declare -a A; A=( 1 2 3 )
# - Associative array/dictionary - declare -A AA; AA=( [one]=1 [two]=2 ) # [key]=value

# Basic syntax elements
# - Text: “Hello world” or 'Hello world'
#   With “”, special characters are interpreted by bash. Specifically, the $ with which variables begin. 
#       This means variable names are expanded. With ', no interpretation takes place
# - Numbers: Only integers
#   Number bases: 0x42 - hexadecimal, 042 - octal

# Calculations (no $ required for variables)

i=0
(( i=i+1 ))
(( i++ ))

# Strings

s="hello"
b=" "
w="world"
s="$s$b$w"

# better

s="${s}${b}${w}"

# Use lists (are zero based)

declare -a A=( "Aeins" "Azwei" "Adrei" "Avier" )

# Use assoziative arrays

declare -A AA=( [eins]=AAeins [zwei]=AAzwei )

# Access elements in list and dictionary
echo "${AA["eins"]}"
echo "${A[0]}"
# Anzahl Elemente
echo "${#A[@]}"
echo "${#AA[@]}"
# Array Keys
echo "${!A[@]}"
echo "${!AA[@]}"
# Array elemente
echo "${A[@]}"
echo "${AA[@]}"
# Element löschen
unset "${A[2]}"
unset "${AA["eins"]}"

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> bash internal functions <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Substring
V="Hello world"
echo "${V:7}"	# world
echo "${V:7:1}" # w

# String substitution
VV="${V/world/folks}"
echo "$VV"

# and much more (see man bash)

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Regular expressions <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if [[ "$VV" =~ ^folks ]]; then
	echo "String starting with folks"
else
	echo "String NOT starting with folks" # match
fi
if [[ "$VV" =~ folks ]]; then
	echo "String contains folks" # match
else
	echo "String does NOT contains folks"
fi

VV="Hello world and folks"
regex="^Hello ([a-zA-Z]+) .+ ([a-zA-Z]+)$"
if [[ $VV =~ $regex ]]; then
		world=${BASH_REMATCH[1]}
		folks=${BASH_REMATCH[2]}
fi
echo "$world $folks"

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> First lines in a script and bash debugging
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Ensure that the bash interpreter is called for the file
#!/bin/env bash
# or
#!/bin/bash
# or explicitly call bash
# bash ./bashBootcamp.sh

# `set -x` enables debug mode in the code, and `set +x` disables it

# Enable debug mode for the entire script
#!/bin/env -S bash -x
# or
#!/bin/bash -x

# Alternatively, run the script with `bash -x <scriptname>`
bash -x ./bashBootcamp.sh

# Improve debug output with line numbers
declare -r PS4='|${LINENO}> \011${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> IF statement <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Complete form

b=true
if $b; then
	echo "true"
else
	echo "false"
fi

# There are several syntactic forms
# I recommend using only the following two forms:
# Text comparison
if [[ "a" == "b" ]]; then
	echo "Equal"
else
	echo "Unequal"
fi
# Numerical comparison
if (( "3" == "4" )); then
	echo "Equal"
else
	echo "Unequal"
fi
# Alternate syntax
# Numerical comparison
# if [ "a" -lt "b" ]  ...fi
# String comparison
# if [ "a" = "b" ] ... fi
# if [ "a" < "b" ] ...fi

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Misc other if tests <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if [[ -f bashBootcamp.sh ]]; then
	echo "Found script"
else
	echo "script not found"
fi

if [[ -d bashBootcamp.sh ]]; then
	echo "Is directory"
else
	echo "Is no directory"
fi

# Use and and or 

V1="eins"
V2="zwei"
if [[ "$V1" == "eins" && "$V2" == "zwei" ]]; then
	echo "Beide sind OK"
fi

if [[ "$V1" == "eins" || "$V2" == "eins" ]]; then
	echo "Eines ist eins"
fi

# WHILE statement

b=true
while $b; do
	echo "Loop"
	b=false
done

while read -r line; do
	echo "$line"
done < bashBootcamp.sh

while read -r client; do
	echo "$line"
done < <(map -sP 192.168.0.0/24)

# break terminates a loop

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> FOR statement <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

for e in "1 2 3"; do
	echo "$e"
done

# or

for (( i=0; i<10; i++ )); do
	echo -n "$i"
done

# continue continues loop

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> DO UNTIL statement <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

i=3
until (( i >= 0 )); do
	echo "$i"
	(( i--))
done

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> SWITCH statement <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

c=123
case $c in
	1* | *2*) echo "switch 1/2"
			;;
	3) echo "switch 3"
			;;
	*) echo "switch default"
esac

# Variable Visibility
# - Child processes can only see exported variables
export EXPORTEDVAR="4711"
NONEXPORTEDVAR="4712"
# ./bashBootcamp.sh # can only see EXPORTEDVAR

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Functions <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Command-line arguments are $1, $2, etc.
# $0 represents all command-line arguments
# Return is the return value of the last command or is explicitly set using return
demo1() {
	echo "Funktion with parameters $1 und $2"
	return 0
}
demo1 "eins" "zwei"

# Variables are global unless they are defined with `local`
# This allows for recursion
# Example: bash forkbomb https://www.cyberciti.biz/faq/understanding-bash-fork-bomb/
# Note: The default is global within functions, meaning every local variable must be declared with `local`

var1="var1_extern"
demo4() {
	echo "demo: var1 extern in demo: $var1"
	local var1
	var1="$1"
	echo "demo: Var1 intern in demo: $var1"
	return 0
}
demo4 "var_intern"
echo "var1 extern: $var1"

# Returnval,ues of functions
# Exitcodes: 0-255
demo2() {
	return $1
}
demo2 0; echo $?
demo2 42; echo $?

# Return result in stdout with echo for example
demo5() {
	echo "$1"
}
demo5 "One"
demo5 "Two"

# Assign the output of a function or script to a variable

RETURNVAR="$(demo "One")"
echo "$RETURNVAR"

# Global variables

VARIABLE="one"
demo3() {
	VARIABLE="$1"
}
echo "$VARIABLE"
demo3 "two"
echo "$VARIABLE"

# Pass the variable name in a function call and store the result in the named variable - printf -v

VARIABLE1="one"
VARIABLE2="two"
demo6() {
	printf -v "$1" "%s", "$2"	# stores value of $2 in variable named in $1 
}
echo "$VARIABLE1 $VARIABLE2"
demo6 "VARIABLE1" "oneone"
demo6 "VARIABLE2" "twotwo"
echo "$VARIABLE1 $VARIABLE2"

# Includes like in C
# source shell scripts, no execution but all defined variables and functions are then known by the sourcing script

source bashBootcamp.sh

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> Here Doc <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Usae constant text in scripts

# bash expansion on
cat <<EOF
   This script is located in $PWD
EOF

# bash expansion off
cat <<'EOF'
   This script is located in $PWD
EOF

# String heredoc <<<

wc -c <<< "Hello world" # counts number of chars

# Usage instead of useless cat "Hello world" | wc -c

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#
# >>> IFS usage <<<
#
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

# Split text
# Attention: No ", otherwise nos split will happen

IFS="."
V="This.is.a.test"
AU=( $V )
AQ=( "$V" )
echo "${#AU[@]}"
for e in "${AU[@]}"; do
	echo "$e"
done
echo "${#AQ[@]}"
for e in "${AQ[@]}"; do
	echo "$e"
done
unset IFS						# reset IFS to default

# Cleaner approach since no globbing is used

IFS="."
V="This.is.a.test"
read -a array <<< $V
for e in "${array[@]}"; do
   echo $e
done
unset IFS						# reset IFS to default

# >>> parameter expansions <<<

# Default Werte für Variablen setzen, Texte ersetzen, Substring,

man bash 2>/dev/null | grep -E 'Parameter Expansion | \${.+}$'

# >>> patterns <<<

# Patterns are mostly used by globbing
# But not with test with [[ .. == .. ]]

v="Hello world"

if [[ "$v" == *[w]* ]]; then
	echo "Found world"
fi

# Case statements

case "$v" in

	*world*) echo "Fund world"
			;;
esac

# string manipulation

v="Hello world and universe"
vm=${v/world*/earth}				# replace world (bash parameter expansion)
echo "$vm"

###########################################################################################
#
# ### Programming exercises ###
#
###########################################################################################

:<<SKIP

See README on https://github.com/pmarf/bashBootcamp

SKIP
