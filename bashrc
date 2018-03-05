#### TODO ####
#sudo systemctl start mysqld
#sudo systemctl start httpd
#create a bell function maxime style
#### TODO ####

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable the Software Flow Control nonsense

PYTHONIOENCODING="UTF-8"
#export LC_ALL=en_US.UTF-8
#export LANG=en_US.UTF-8
#export LANGUAGE=en_US.UTF-8
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME=/usr/local/cuda
alias battery='acpi -i'
alias sb='source ~/.bashrc'
alias vv='vim ~/.vimrc'
alias vb='vim ~/.bashrc'
alias ls='ls -Fv --color=always' # ls with colors and file type,v is for number sort
alias la='ls -Av' #ls with relevant hidden files
alias ll='ls -lahsv' #ls with long format and size
alias grep='grep --color=always' # grep with colors
alias mkdir='mkdir -p' # To create the parent directories
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -czvf'
alias R='R --no-save --silent'
alias studio='/bin/rstudio-bin'
alias sublime='/bin/subl3' # subl3 is ugly too
alias tree='/bin/tree -C --dirsfirst' # tree with color and directories first
alias eclim='/home/piggygenius/.eclipse/org.eclipse.platform_4.7.0_155965261_linux_gtk_x86_64/eclimd &'
alias ssh-ensimag='ssh carrel@pcserveur.ensimag.fr'
alias sftp-ensimag='sftp carrel@pcserveur.ensimag.fr'
alias ssh-bigdata='ssh carrel@bigdata.ensimag.fr'
alias sftp-seedbox='sftp ludo.itr_11585@izac.myseedbox.site'
alias screenshut='screen -X eval "msgwait 0"'
alias ipython='ipython --no-banner'

CPU=$(grep -c bogomips /proc/cpuinfo)
function startscreen(){
	if [ $# -eq 0 ]; then
		screen -S slave
	else
		screen -S $1
	fi
	screen -X eval "msgwait 0"
}

function mem(){
	free=$(free -m | awk 'NR==2 {print$4}')
	total=$(free -m | awk 'NR==2 {print$2}')
    echo "scale=2;100-($free*100/$total)" | bc -l
}
function html(){
	name=$(basename $1 .md)
	notedown $1 --run > $name.ipynb
	jupyter nbconvert --to html $name.ipynb &> /dev/null
}
function trim_spaces(){
	for file in *; do mv "$file" `echo $file | tr ' ' '_'` ; done
}
function trim_par(){
	for file in *; do mv "$file" `echo $file | tr -d '()'` ; done
}
### TEMP ###
#for file in *; do sub=`echo $file | sed 's/Batman_[0-9]*//g'`;mv "$file" "${file%${sub}}".cbr; done
### TEMP ###
function light(){
	if [ "$1" == "down" ]; then
		if [ $# -eq 1 ]; then
			xbacklight -dec 20
		else
			xbacklight -dec $2
		fi
	elif [ "$1" == "up" ]; then
		if [ $# -eq 1 ]; then
			xbacklight -inc 20
		else
			xbacklight -inc $2
		fi
	fi
}
function sound(){
	if [ $# -eq 0 ]; then
		amixer set Master toggle &> /dev/null
	else
		if [ "$1" == "down" ]; then
			if [ $# -eq 1 ]; then
				amixer set Master playback 10- &> /dev/null
			else
				amixer set Master playback "$2"- &> /dev/null
			fi
		elif [ "$1" == "up" ]; then
			if [ $# -eq 1 ]; then
				amixer set Master playback 10+ &> /dev/null
			else
				amixer set Master playback "$2"+ &> /dev/null
			fi
		fi
	fi
}
function screenshot(){
	gnome-screenshot -a -f $1
}
function maketree(){
	name=$(basename $1 .dot)
	dot -Tpng $1 -o $name.png
}
function sshclone(){
	if [ $# -eq 1 ]; then
		git clone ssh://git@github.com/PiggyGenius/$1.git
	else
		git clone ssh://git@github.com/$1/$2.git
	fi
}
function pdf(){
	name=$(basename $1 .tex)
	pdflatex $1
	biber $name
	pdflatex $1
	pdflatex $1
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
function gnatmake(){
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
    PS1+="\[${GREEN}\]\$(basename '$VIRTUAL_ENV')"
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
