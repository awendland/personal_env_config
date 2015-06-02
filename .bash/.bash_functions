#!/bin/bash

# bash_functions

#H Functions - Code Helpers
#A List available personal commands
function bashcmds() {
  cd $( dirname "${BASH_SOURCE[0]}" )
  python "$( pwd )/printout_cmds.py"
  cd -
}

#A Copy the appropriate files over
function installdotfiles() {
  if [ -f .bashrc ]; then
    cp .bash/.* ~/.bash/
    cp .bash/*.* ~/.bash/
    cp .bash_profile ~/
    cp .bashrc ~/
    cp .screenrc ~/
    cp .gitignore_global ~/
    echo ""
    echo "dotfiles copied to home directory"
    git config --global core.excludesfile ~/.gitignore_global
    echo "global gitignore installed"
  else
     echo "Error: cwd must be in the root personal_env_config dir"
  fi
}

#A Setup simple client-side web repo
function fleshweb() {
	echo ""
	if [ -z "$1" ]; then
		echo "No repository name supplied"
	else
		git clone https://github.com/awendland/simple-web-boilerplate.git "$1"
		cd "$1"
		rm -rf ".git/"
		git init
		echo ""
		echo "Fleshed out \"$1\""
		cd ..
	fi
}

#A Print out ansi code table
function ansicodes() {
  printf "Setup -> \\\\033[CODE\nRESET -> \\\\033[0m"
	T='gYw'   # The test text
	echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";
	for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m';
	    do FG=${FGs// /}
	    echo -en " $FGs \033[$FG  $T  "
	    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
	        do echo -en "$EINS \033[$FG\033[$BG  $T \033[0m\033[$BG \033[0m";
	    done
	    echo;
	done
	echo
}

#A Epoch time conversion
# http://www.quora.com/What-are-some-of-the-best-command-prompt-or-the-terminal-tricks/answer/Dave-Kimber-1
function epoch() {
  TESTREG="[\d{10}]"
  if [[ "$1" =~ $TESTREG ]]; then
    # is epoch
    date -d @$*
  else
    # is date
    if [ $# -gt 0 ]; then
      date +%s --date="$*"
    else
      date +%s
    fi
  fi
}

#A Easily extract all compressed file types
# http://www.quora.com/What-are-some-of-the-best-command-prompt-or-the-terminal-tricks/answer/Dave-Kimber-1
function extract () {
   if [ -f "$1" ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf -- "$1"    ;;
           *.tar.gz)    tar xvzf -- "$1"    ;;
           *.bz2)       bunzip2 -- "$1"     ;;
           *.rar)       unrar x -- "$1"     ;;
           *.gz)        gunzip -- "$1"      ;;
           *.tar)       tar xvf -- "$1"     ;;
           *.tbz2)      tar xvjf -- "$1"    ;;
           *.tgz)       tar xvzf -- "$1"    ;;
           *.zip)       unzip -- "$1"       ;;
           *.Z)         uncompress -- "$1"  ;;
           *.7z)        7z x -- "$1"        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

#H Functions - Other Helpers
#A Define a word using collinsdictionary.com
# http://www.quora.com/What-are-some-of-the-best-command-prompt-or-the-terminal-tricks/answer/Dave-Kimber-1
function define() {
  curl -s "http://www.collinsdictionary.com/dictionary/english/$*" | sed -n '/class="def"/p' | awk '{gsub(/.*<span class="def">|<\/span>.*/,"");print}' | sed "s/<[^>]\+>//g";
}