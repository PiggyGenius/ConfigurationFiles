#### TODO ####
#sudo systemctl start mysqld
#sudo systemctl start httpd
#### TODO ####

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable the Software Flow Control nonsense


alias ls='ls -Fv --color=always' # ls with colors and file type,v is for number sort
alias la='ls -Av' #ls with relevant hidden files
alias ll='ls -lasv' #ls with long format and size
alias grep='grep --color=always' # grep with colors
alias mkdir='mkdir -p' # To create the parent directories
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -czvf'
alias R='R --no-save --silent'
alias studio='/bin/rstudio-bin'
alias sublime='/bin/subl3' # subl3 is ugly too
alias tree='/bin/tree -C --dirsfirst' # tree with color and directories first
alias eclim='/home/piggygenius/.eclipse/org.eclipse.platform_4.6.1_155965261_linux_gtk_x86_64/eclimd > /dev/null 2>&1'

CPU=$(grep -c bogomips /proc/cpuinfo)
function mem(){
	free=$(free | awk 'FNR==2 {print$4}')
	total=$(free | awk 'FNR==2 {print$2}')
	echo "scale=2;100-($free*100/$total)" | bc -l
}
function screenshot(){
	gnome-screenshot -a -f $1
}
function maketree(){
	name=$(basename $1 .dot)
	dot -Tpng $1 -o $name.png
}
function pdf(){
	name=$(basename $1 .tex)
	pdflatex $1
	rm $name.log $name.aux
}
function chrome(){
	xdg-open $1 &> /dev/null
}
function extract(){
	unp $1
	rm $1
}
function untar(){
	tar -xvf $1
	rm $1
}
function untarz(){
	tar -xzvf $1
	rm $1
}
function unzip(){
	unzip $1
	rm $1
}
function gnatf(){
	gnatmake $1
	rm *.ali
	rm *.o
}
function cpu(){
	load_avrg=$(cut -d ' ' -f 1 /proc/loadavg)
	echo "scale=2;$load_avrg*100/$CPU" | bc -l
}
function google(){
	search=""
	for term in $@; do
		search="$search%20$term"
	done
	xdg-open "http://www.google.com/search?q=$search" &>/tmp/null
}
function getip(){
	echo -n "Internal IP: "; hostname -i
	echo -n "External IP: "; wget http://ipinfo.io/ip -qO -
}
alias gnatmake="gnatf"

export HISTFILESIZE=10000
export HISTSIZE=500
# Only store different commands in bash_history
export HISTCONTROL=ignoreboth:erasedups
# shopt is used to -set or -unset bash options
shopt -s histappend # Makes bash append history when new terminal is opened
PROMPT_COMMAND='history -a' # Appends the history at startup
bind "set show-all-if-ambiguous On" # Show completion with single tab
# Color for manpages in less makes manpages a little easier to read,from archwiki
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# Setup the prompt
function __setprompt
{
	local LAST_COMMAND=$? # Must come first!

	# Define colors
	local LIGHTGRAY="\033[0;37m"
	local WHITE="\033[1;37m"
	local BLACK="\033[0;30m"
	local DARKGRAY="\033[1;30m"
	local RED="\033[0;31m"
	local LIGHTRED="\033[1;31m"
	local GREEN="\033[0;32m"
	local LIGHTGREEN="\033[1;32m"
	local BROWN="\033[0;33m"
	local YELLOW="\033[1;33m"
	local BLUE="\033[0;34m"
	local LIGHTBLUE="\033[1;34m"
	local MAGENTA="\033[0;35m"
	local LIGHTMAGENTA="\033[1;35m"
	local CYAN="\033[0;36m"
	local LIGHTCYAN="\033[1;36m"
	local NOCOLOR="\033[0m"


	PS1="" # Resetting PS1
	PS1+="\[${MAGENTA}\]CPU:$(cpu)%-" # Display CPU usage
	PS1+="\[${MAGENTA}\]RAM:$(mem)%|" # Display RAM usage
	PS1+="\[${DARKGRAY}\]\[${BROWN}\]\w\[${DARKGRAY}\]\n" # Directory hierarchy
	PS1+="\[${GREEN}\]>\[${NOCOLOR}\] " # Green input arrow

	# PS2 is used to continue a command using the \ character
	PS2="\[${DARKGRAY}\]>\[${NOCOLOR}\] "

	# PS3 is used to enter a number choice in a script
	PS3='Please enter a number from above list: '

	# PS4 is used for tracing a script in debug mode
	PS4='\[${DARKGRAY}\]+\[${NOCOLOR}\] '
}
PROMPT_COMMAND='__setprompt'
