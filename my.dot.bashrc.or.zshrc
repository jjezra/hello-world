
# This is shared .bashrc and .zshrc user init file.
# Users can set one init file as a symlink the other (as in "ln -s .bashrc .zshrc")
#
# (c) 2012 Josef Ezra <jezra@cpan.org>
#
# This was created for my own use. You're welcomed to borrow it on your own risk.


#################################
# SHARED

# If not running interactively, don't do anything
[ -z "$PS1" ] && return # exit - this kills sftp, should be set as wrapper

[ -z "$BASH" ] && IS_ZSH=1 || IS_BASH=1

function pushpath() {
    if [ -d ${1} ] ; then
        # PATH="${1}:$PATH"
        PATH=`perl -e 'my ($a, $b) = @ARGV; print $a =~ /^$b$|^$b\:|:$b$|:$b:/ ? $a : "$b:$a\n"' $PATH ${1}`
    fi
}

function setenv() {
    export $1="$2"
} # csh like

pushpath ~/bin
pushpath ~/local/bin
pushpath ~/Perl/bin
pushpath /sbin
pushpath /usr/local/opt/grep/libexec/gnubin # brew's grep

function hlp    () {
    eval "grep -hi $* ~/mydoc/myHelp.doc"
}
function hlpput () {
    eval "echo $* >>  ~/mydoc/myHelp.doc"
}
function h ()  {
    eval "history | grep $*"
}
function l ()  {
    eval "${@:1}" | less -FRiX
}
function psg() {
    ps -Af | egrep -v "grep +.*$1" | grep --color $1
}
function git-files-changed() {
    git log -1 -p $* | perl -nle '/diff --git a\/(\S*) / and print $1'
}
function gituu() {
    git st | perl -ne '/UU +(\S+)/ and push @a, $1 and print; END{ exec "emacs @a ; git add @a"}'
}
setenv SAVEHIST   10000
setenv HISTSIZE   10000
setenv LESS       "-i -R"
setenv GIT_EDITOR "emacs -nw"
setenv EDITOR     "emacs -nw"
setenv PAGER      "less"

# Avoid annoying terminal messages
unset MAILCHECK


# aliases
alias gitt='git --no-pager'
alias ll='ls -alFh'
alias lk='ls -al'
alias la='ls -A'
alias lf='ls -CF'

alias resource='unset $self_marker; source ~/.bashrc'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    COLOR_AUTO='--color=auto'
fi

alias ls="ls $COLOR_AUTO"
alias dir="dir $COLOR_AUTO"
alias vdir="vdir $COLOR_AUTO"
# setenv GREP_OPTIONS "$COLOR_AUTO --exclude='*~' --exclude=TAGS --exclude-dir=.git"
alias grep="grep $COLOR_AUTO --exclude='*~' --exclude=TAGS --exclude-dir=.git"

alias -- -="cd -"
alias gdb="gdb -q"
alias time_mem="/usr/bin/time -f '\n%C:\n%SSEC kernel, %USEC user, %ESEC real, %P cpu, %MKB mem, exit %x' "
alias hdw="hexdump -s 8 -e '4 \" %08x\" \"\n\"'"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

test -f ~/.bashrc.local && . ~/.bashrc.local


######################
# IS_ZSH

if [ $IS_ZSH ]; then
    # echo I am zsh
    #######################
    alias hlpopt="man zshoptions"

    HISTFILE=~/.zsh_history

# from frew: (TODO: cleanup)
    _force_rehash() {
        (( CURRENT == 1 )) && rehash
        return 1 # Because we didn't really complete anything
    }

    setopt MULTIOS
    setopt AUTO_NAME_DIRS
    setopt GLOB_COMPLETE
    setopt PUSHD_TO_HOME
    setopt PUSHD_IGNORE_DUPS
    setopt RM_STAR_WAIT         # 10 seconds
    setopt ZLE
    setopt NO_HUP               # keep bg alive at exit
    setopt NO_FLOW_CONTROL
    setopt NO_BEEP
    setopt NO_CLOBBER
    setopt NUMERIC_GLOB_SORT
    setopt EXTENDED_GLOB
    setopt RC_EXPAND_PARAM      # xx=(1 2 3) ; echo aa${xx}aa ==> aa1aa aa2aa aa3aa
    unsetopt LIST_AMBIGUOUS
    setopt  COMPLETE_IN_WORD
    # hist
    setopt APPEND_HISTORY
    setopt HIST_IGNORE_DUPS
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_REDUCE_BLANKS
    setopt HIST_IGNORE_SPACE
    setopt HIST_NO_STORE
    setopt HIST_VERIFY
    setopt HIST_SAVE_NO_DUPS
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt HIST_FIND_NO_DUPS

    typeset -U path
    zstyle ':completion::complete:*' use-cache 1
# case insensitive completion
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*' verbose yes
    zstyle ':completion:*:descriptions' format '%B%d%b'
    zstyle ':completion:*:messages' format '%d'
    zstyle ':completion:*:warnings' format 'No matches for: %d'
    zstyle ':completion:*' group-name ''
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete
    zstyle ':completion:*' completer _expand _force_rehash _complete _approximate _ignored
# generate descriptions with magic.
    zstyle ':completion:*' auto-description 'specify: %d'
# Don't prompt for a huge list, page it!
    zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Don't prompt for a huge list, menu it!
    zstyle ':completion:*:default' menu 'select=0'
# Have the newer files last so I see them first
    zstyle ':completion:*' file-sort modification reverse
# color code completion!!!!  Wohoo!
    zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
# Separate man page sections.  Neat.
    zstyle ':completion:*:manuals' separate-sections true
# Egomaniac!
    zstyle ':completion:*' list-separator 'fREW'
# complete with a menu for xwindow ids
    zstyle ':completion:*:windows' menu on=0
    zstyle ':completion:*:expand:*' tag-order all-expansions
# more errors allowed for large words and fewer for small words
    zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'
# Errors format
    zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'
# Don't complete stuff already on the line
    zstyle ':completion::*:(rm|vi):*' ignore-line true
# Don't complete directory we are already in (../here)
    zstyle ':completion:*' ignore-parents parent pwd
    zstyle ':completion::approximate*:*' prefix-needed false
# prompt
    autoload -U colors && colors
    host_prompt="%{$fg_bold[cyan]%}%m%{$reset_color%}"
    time_total="%{$fg[yellow]%}%T%{$reset_color%}"
    case "$USER" in
        (root) post_prompt="%{$fg_bold[red]%}=)%{$reset_color%}" ;;
        (*)    post_prompt="%{$fg_bold[green]%}=)%{$reset_color%}" ;;
    esac

    PS1="%{$fg[yellow]%}%j%{$reset_color%}${host_prompt} ${time_total} ${post_prompt} "
    RPS1="%{$fg[magenta]%}%~%{$reset_color%} "

# And few more
    autoload -U select-word-style
    select-word-style bash

    autoload -U compinit promptinit
    # compinit

    autoload zmv                    # rename mass files: zmv -W '*.foo' '*.bar'

    _complete_files () {
        compadd - $PREFIX*
    }
    zle -C complete complete-word _complete_files
    bindkey '^Z' complete

    alias which-command="where"
    alias wh="where"
    bindkey -e
    alias z=exit

elif [ $IS_BASH ]; then
    # echo I am bash
    #######################

    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

    # alias  gitmf="git --git-dir=mf/.git"
    complete -o bashdefault -o default -o nospace -F _git gitmf 2>/dev/null || complete -o default -o nospace -F _git gitmf

    alias hlpopt="man bash-builtins"

    HISTFILE=~/.bash_history
    HISTCONTROL=ignoredups:erasedups
    HISTFILESIZE=200000
    shopt -s histappend
    shopt -s histreedit
    shopt -s cmdhist globstar
    shopt -u huponexit

    shopt -s cdspell dotglob  # autocd
    # shopt -s checkwinsize
    shopt -s interactive_comments expand_aliases
    shopt -s hostcomplete

    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi
    if [ -z "`complete | grep -w git`" ]; then
        if [ -f ~/.bash_completion.git ]; then
            . ~/.bash_completion.git
        fi
    fi

    function prompt_fancy() {
        case "${1}" in
            1) PS1='\[\e[34m\]┌─[\[\e[37m\]\u@\t\[\e[34m\]] \n└─[\[\e[37m\]\W\[\e[34m\]]> ' ;;
            2) PS1='\[\e[0;32m\]┌┼───┤\[\e[0;36m\] \u@\h \[\e[0;32m\]├────────────────────────────────┤\[\e[0;33m\]\w\[\e[0;32m\]├────\n└┼─\[\e[1;33m\]$\[\e[0;32m\]─┤▶ \[\e[0;37m\]' ;;
            noc*) PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ ' ;;
            *) PS1="\[\033[35m\]\t\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]$ " ;;
        esac
    }

    case "$TERM" in
        *dumb*) prompt_fancy noc ;;
        *)      prompt_fancy     ;;
    esac

    alias z=zsh
    alias wh=which

fi
