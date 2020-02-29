#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PROMPT_COMMAND=__prompt_command

__prompt_command() {
  local EXIT="$?"
  PS1=""

  BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
  if [ "${USER}" = "root" ]; then
    if [ $EXIT != 0 ]; then
      PS1='\[\e[31m\]\u\[\e[94m\]@\h\[\e[39m\]\[\e[34m\]${BRANCH}\[\e[39m\] \[\e[93m\]\W\[\e[39m\] \[\e[31m\]\$\[\e[39m\] '
    else
      PS1='\[\e[31m\]\u\[\e[94m\]@\h\[\e[39m\]\[\e[34m\]${BRANCH}\[\e[39m\] \[\e[93m\]\W\[\e[39m\] \[\e[32m\]\$\[\e[39m\] '
    fi
  elif [ "${USER}" = "ansible" ]; then
    if [ $EXIT != 0 ]; then
      PS1='\[\e[95m\]\u\[\e[94m\]@\h\[\e[39m\]\[\e[34m\]${BRANCH}\[\e[39m\] \[\e[93m\]\W\[\e[39m\] \[\e[31m\]\$\[\e[39m\] '
    else
      PS1='\[\e[95m\]\u\[\e[94m\]@\h\[\e[39m\]\[\e[34m\]${BRANCH}\[\e[39m\] \[\e[93m\]\W\[\e[39m\] \[\e[32m\]\$\[\e[39m\] '
    fi
  else
    if [ $EXIT != 0 ]; then
      PS1='\[\e[92m\]\u\[\e[94m\]@\h\[\e[39m\]\[\e[34m\]${BRANCH}\[\e[39m\] \[\e[93m\]\W\[\e[39m\] \[\e[31m\]\$\[\e[39m\] '
    else
      PS1='\[\e[92m\]\u\[\e[94m\]@\h\[\e[39m\]\[\e[34m\]${BRANCH}\[\e[39m\] \[\e[93m\]\W\[\e[39m\] \[\e[32m\]\$\[\e[39m\] '
    fi
  fi
}


alias vi="vim"
alias ls="ls --color=auto"
alias pacman="pacman --color=always"
alias yaourt="yaourt --color"
alias less="less -R"

alias gs="git status"
alias ga="git add ."
alias gc="~/scripts/commit.sh"
alias gp="~/scripts/push.sh"

#!/bin/bash

branch=$(git rev-parse --abbrev-ref HEAD)

function push () {
  git push -u origin "$branch"
}
push

#!/bin/bash

function commit () {
  git commit -am "$1"
}
commit $1



case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
  screen)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

export PATH=~/bin:~/.local/bin:~/go/bin:$PATH

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
