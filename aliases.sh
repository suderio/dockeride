#!/bin/sh

# User specific aliases and functions
alias diff='colordiff'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias update='sudo apt update && sudo apt upgrade'
alias updatey='sudo apt update && sudo apt -y upgrade'
alias rut='sudo -i'
alias su='sudo -i'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CFlh'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias lsd="ls -alF | grep /$"

alias greset='git clean -f && git reset --hard'

alias dckr='sudo docker'

## pass options to free ## 
alias meminfo='free -m -l -t'
 
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
 
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
 
## Get server cpu info ##
alias cpuinfo='lscpu'
 
## older system use /proc/cpuinfo ##
##alias cpuinfo='less /proc/cpuinfo' ##
 
## get GPU ram on desktop / laptop## 
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'


# This is GOLD for finding out what is taking so much space on your drives!
alias diskspace="du -S | sort -n -r |more"
alias dockrrmi='docker images | grep '\''<none>'\'' | grep -P '\''[1234567890abcdef]{12}'\'' -o | xargs -L1 docker rmi'
alias dockrrm='docker ps -a | grep -v '\''CONTAINER\|_config\|_data\|_run'\'' | cut -c-12 | xargs docker rm'
alias dockerm='docker rm -v $(docker ps -a -q -f status=exited)'
alias dockermi='docker rmi $(docker images -f "dangling=true" -q)'
alias dockermv='docker volume rm $(docker volume ls -qf dangling=true)'
alias geckout='git checkout'
alias gistatus='git status'
alias gull='git pull --all'
alias gush='git push --all'
alias gac='git add --all && git commit -m'

alias lcd=changeDirectory
function changeDirectory {
  cd $1 ; ls -la
}
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias vinx='vim -X'
alias vim='nvim'

alias apt-installed="comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u)"

alias restmux='[[ -z "$TMUX" ]] && exec tmux new-session -A -s $USER'

