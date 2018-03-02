#!/usr/bin/env bash
# TODO: do something with LIBDIR_NAME
# http://tldp.org/LDP/abs/html/internalvariables.html
! test "${BASH_VERSION}" && echo "THIS PROFILE WORKS ONLY WITH BASH. You got 5 secs to hit CTRL+C before exit 99..." 2>&1 && sleep 5 && exit 99
# Re-init the profile. Totally. Remember this script is meant to be your profile. Forget ~/.profile and ~/.barhrc
. /etc/profile 2>/dev/null

set -a
ENTITY=THECUS
PROFILE_VERSION=3.6.5
command unset LD_PRELOAD ls_colors grep_colors
command unalias alias id ls rm cp mv du df ps vim tar ssh scp more less grep lsof egrep which whichh uname screen whoami hostname psef 2>/dev/null

# The easiest way for the unit tests to know whether or not they are running on a terminal is to test of the stdio file descritors refer to a terminal:
# [ -t 0 ] && TTY=true || TTY=false
# line bellow works for ash/busybox:
[[ $- == *i* ]] && TTY=true || TTY=false
[ "x$1" == "xlight" ] && TTY=false && shift

# BASENAME=$(basename $0)
# DIRNAME=$([ -s "./$0" ] && pwd || dirname $0)
# SCRIPT=${BASENAME%\.*}

############################################################## profile ########################################################################
[ "$(uname -s)" == "AIX" ] && PATH=/usr/bin:/etc:/usr/sbin:/usr/ucb:/usr/bin/X11:/sbin:/usr/ccs/bin:/usr/dt/bin:/usr/opt/perl5/bin:/opt/freeware/bin:/opt/freeware/sbin:/usr/local/bin:/usr/lib/instl:/usr/java5/jre/bin:/usr/java5/bin
HOSTNAME=$(hostname) && HOSTNAME=${HOSTNAME%%\.*}
# TODO: handle DIREXPLOIT detection for BASH_VERSINFO < 3
((BASH_VERSINFO > 2)) && DIREXPLOIT="$( cd $( dirname $(readlink -f ${BASH_SOURCE[0]}) ) && pwd -P )" || DIREXPLOIT=/jffs/exploit
[ "${DIREXPLOIT}" == "." ] && DIREXPLOIT=$PWD

Debug=false
Verbose=false
# par defaut on affiche tout bien sur... Echo est une fonction
# Echo=NOEcho
Echo=Echo
PAUSE=false

umask 0002
UNAME=$(uname -s)
MARCH=$(uname -m)
REVISION=$(uname -r)
KERNELV=$(uname -r | cut -c-3)
OLDAIX=false
[ -z "${LOGNAME}" ] && LOGNAME=$(whoami)
bit=32

bashLoadFunc() {
# http://linux.about.com/library/cmd/blcmdl1_bash.htm
# disable expand_aliases coz some functions have an alias name so eval will return an error if the alias exists and expand_aliases=on. Solution is to declare the function such as "function funcname ()" in the script, instead of just "funcname ()"
shopt -u expand_aliases 2>/dev/null
eval $1 '() { unalias '$1' 2>/dev/null ; . '$2' ; '$1' "$@" ; return $? ; }'
export -f $1
shopt -s expand_aliases 2>/dev/null
# enable aliases
}

bashLoadFpath() {
[ -z "$FPATH" ] && return 1
local fpath fpaths FUNC VERBOSE
VERBOSE=false
fpaths=${FPATH/#:/.:}
fpaths=${fpaths//::/:.:}
fpaths=${fpaths/%:/:.}
fpaths=${fpaths//:/ }
[ "x$1" == "x-v" ] && VERBOSE=true

# now parsing all FPATH directories...
for fpath in $fpaths ; do
  if [ -d "$fpath" ] ; then
    [ "${UNAME}" != "AIX" -a -z "${fpath#*AIX}" ] && continue
    [ "${UNAME}" != "Linux" -a -z "${fpath#*Linux}" ] && continue
    [ "${UNAME}" != "SunOS" -a -z "${fpath#*SunOS}" ] && continue
    $VERBOSE && echo "bashLoadFunc reload $fpath ..."
    for FUNC in $fpath/*; do bashLoadFunc ${FUNC##*/} $FUNC; done
  fi
  shift
done
}

# https://groups.google.com/forum/#!topic/mintty-discuss/8mCkdAPD-sE
# xargs --show-limits
[ "${TERM}" == "cygwin" ] && FPATH_EXCLUDED="APRIA|AIX|apache|CNETI|crossCompiler|PLI|SunOS|THECUS|was|Linux" || FPATH_EXCLUDED="none"
unset FPATH; for dir in $(ls -d ${DIREXPLOIT}/FPATH/* | egrep -v "${FPATH_EXCLUDED}" 2>/dev/null); do FPATH=${FPATH}${FPATH:+:}${dir}; done

if test "${BASH_VERSION}"; then
  bashLoadFpath
  # set -o pipefail     # Unavailable with BASH_VERSINFO < 3, and a hassle to handle later in the other functions. Abandoned.
fi

# For root users, ensure that /usr/local/sbin, /usr/sbin, and /sbin are in $PATH.
# Some means of connection don't add these by default (sshd comes to mind)
if [ "$(id -u)" = "0" ]; then
  pathmunge /usr/local/sbin
  pathmunge /usr/sbin
  pathmunge /sbin
fi

OPT_PATH=/opt
pathmunge ${DIREXPLOIT}/bin
pathmunge ${DIREXPLOIT}/bin/${UNAME}
pathmunge ${DIREXPLOIT}/bin/${UNAME}.${bit}
pathmunge ${DIREXPLOIT}/bin/${UNAME}.${KERNELV}
pathmunge ${DIREXPLOIT}/bin/${UNAME}.${KERNELV}.${bit}

libmunge ${DIREXPLOIT}/lib/${UNAME}.${KERNELV}.${bit} after
libmunge ${DIREXPLOIT}/lib/${UNAME}.${KERNELV} after
#libmunge ${DIREXPLOIT}/lib/${UNAME}.${bit} after
libmunge ${DIREXPLOIT}/lib/${UNAME} after
$OLDAIX && unset LIBPATH && libmunge ${DIREXPLOIT}/lib/${UNAME} after

[ -s "${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${HOSTNAME}.sh" ] && . ${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${HOSTNAME}.sh

whichh() {
#@(t)  |UNAME |out|mod|set|sys|net|app|mis| description                                                                                        |
#@(p)  |SunOS | x |   |   | x |   |   |   | emulate correct "which" behaviour on SunOS: what a shame, even the stderr is NOT handled           |
! (($#)) && return 255

local which=$(which "$1" 2>&1)
# local which=$(type -p "$1" 2>&1)
# if [ "${which}" == "${which%no ${1% *}*}" ]; then
if [ -x "${which}" ]; then
  echo "${which}"
  return 0
else
  return 1
fi
}

LF="\n"
patterner=${DIREXPLOIT}/etc/patterner.awk
timestamp=${DIREXPLOIT}/etc/timestamp.pl
[ ! -x ${timestamp} ] && timestamp=cat
# /etc/redhat-release /etc/debian_version /etc/issue
version='$Echo ${W} DATE "${UNAME} ${KERNELV} ${bit} ${MACHTYPE}" "${HOSTNAME} $(cat /etc/*release 2>/dev/null|head -1) $(uname -rms) ${BASH_VERSION:++BASH $BASH_VERSION}" ${PROFILE_VERSION}'

# scp='scp -o UserKnownHostsFile=/dev/null'
scp='scp -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no'
ssh='ssh -A -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no'
echo=echo
sps=ps
More=less
PsWw=""
# Pseo= USER:1 PID:2 PPID:3 CPU:4 PCPU:5 ETIME:6 TTY:7 PTIME:8 CMD:9 ARGS:10+
# INFO: stime doesn't not work on IBM AIX: it returns the proces status (A, W, etc)
#  time = total runtime = hh:mm:ss
# etime = elapsed time = [[ dd-]hh:]mm:ss
Pseo="eo user,pid,ppid,cpu,pcpu,etime,tty,time,args"
iname=iname
# INFO: the shitty SunOS "which" command always returns 0
whichh gawk >/dev/null 2>&1 && awk=$(which gawk 2>/dev/null) || awk=awk
whichh gtar >/dev/null 2>&1 && tar=$(which gtar 2>/dev/null) || tar=tar
psef='command ps -${Pseo} | command grep -v -- grep | command grep -E'
lsofni='command lsof ${lsof_options} -nRPi'
lsofi='command lsof ${lsof_options} -RPi'

# wget_options and WGETRC can be set differently according to what's in ${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${ENTITY}.sh
wget_options='--no-check-certificate -e robots=off -e cache=off -e prefer-family=IPv4 --restrict-file-names=windows --content-disposition --random-wait --user-agent="Mozilla/5.0"'
wget="command wget ${wget_options}"
WGETRC=${DIREXPLOIT}/etc/wgetrc
no_proxy=${no_proxy:-".local,.localdomain,proxy,localhost,127.0.0.1,localaddress,.localdomain.com,192.168.*,10.*,172.*,169.*"}

# https://www.biostars.org/p/63816/
# INFO: accessing exported functions with parallel is ONLY possible with SHELL=.../bash
# http://www.gnu.org/software/parallel/parallel_tutorial.html
SHELL=/bin/bash
parallelJobs=12
remoteUser=root
remoteProfile="{ . ${DIREXPLOIT}/profile.apria.sh >/dev/null 2>&1; }"
remoteProfileLight="{ export FPATH=${FPATH}; export PATH=$PATH; setDate; setColors; }"

initDir=/etc/init.d
[ -d "/etc/rc.d" ] && rcDir=/etc/rc.d || rcDir=/etc/init.d
rcDir_default=${rcDir}/rc3.d

LANGUAGE="en_US"
LANGUAGE_TYPE="utf|8859"

case ${UNAME} in
AIX)
  pathmunge /opt/freeware/bin
  sps=/usr/sysv/bin/ps
  iname=name
  RAM=$(lsattr -HE -l sys0 -a realmem | tail -1 | ${awk} '{print $2}')
  KERNELV=$(oslevel | cut -c-3)
  bit=$(getconf KERNEL_BITMODE)
  typeset -lL1 bear 2>/dev/null
  rcDir=/etc/rc.d/rc2.d
  ([ "${UNAME}" == "AIX" ] && floatCompare "$KERNELV < 6.1") && OLDAIX=true
  $OLDAIX && Pseo=ef
  # this test would be false on an OLDAIX: find $DIREXPLOIT/FPATH -type d -print0 | xargs -0 ls -d
  ;;
Linux)
  whichh printf >/dev/null 2>&1 && print=printf || print=print                         # Mandriva doesn't know about printf
  echo=${print}
  PsWw=www
  Pseo=${PsWw}${Pseo}
  echo ${MARCH} | command egrep -i "64|ARMv8" >/dev/null && bit=64
  # alias psef='/usr/sysv/bin/ps -${PsWw}eA -o user,pid,ppid,pcpu,pmem,rss,vsz,time,tty,args | sort -k10 -k 3 -k2 | egrepi -E'
  ;;
SunOS)
  # http://wiki.bash-hackers.org/commands/builtin/printf
  # Solaris version of /bin/echo is equivalent to: printf "%b\n" "$*"
  # SunOS: useless to try to handle anything aroung grep or egrep; let's use the functions instead: so unalias them as well
  Pseo="eo user,pid,ppid,pcpu,pcpu,etime,tty,time,args"
  whichh nawk >/dev/null 2>&1 && awk=$(which nawk 2>/dev/null)
  echo ${MARCH} | command grep 64 >/dev/null && bit=64
  typeset -lL1 bear 2>/dev/null
  # /usr/ucb/ps -algxwww => F   UID   PID  PPID %C PRI NI   SZ  RSS    WCHAN S TT        TIME COMMAND
  psef='/usr/ucb/ps -algxwww | /bin/grep -v -- grep | egrep'
  ;;
esac

Cr=0
CR=0
NbKO=0
FQDN=$(getDNS ${HOSTNAME})

# http://wiki.bash-hackers.org/commands/builtin/printf
line211="$(printf "%211s" "")"
Blank="${line211}"
# one day or another this profile will refuse KSH and forever
if [ "${BASH_VERSION}" ]; then
  Separator="${line211// /-}"
  Filler="${line211// /.}"
else
  Separator="$(echo "${line211}" | tr ' ' '-')"
  Filler="$(echo "${line211}" | tr ' ' '.')"
fi

############################################################## TTY ########################################################################
if $TTY; then
# infocmp xterm-256color >xterm-256color.tic && tic xterm-256color.tic ==> /usr/share/[lib/]terminfo/x/xterm-256color
if [ "${TERM}" != "cygwin" ]; then
  CURRENT_TERM=$TERM
  TERM=xterm-256color # TERM has to be temporarily forced to 256 for tput to work
  tput colors >/dev/null 2>&1 && [ "$(tput colors)" = "256" ] && TERM=xterm-256color || TERM=$CURRENT_TERM
fi

# WARNING: with bash, aliases are expanded inside functions, via (shopt) expand_aliases, which can lead to dramatic consequences
alias br='command sync; bashLoadFpath'

alias cd_exp='cd ${DIREXPLOIT}'
alias cdexp='cd ${DIREXPLOIT}'
alias cdi='cd /etc/init.d'
alias cd2='cd /etc/rc.d/rc2.d'

alias path='echo export PATH=$PATH'
alias fpath='echo export FPATH=$FPATH'
alias lpath='echo export LD_LIBRARY_PATH=$LD_LIBRARY_PATH'
alias ppath='echo $PATH | tr ":" "\n" | sort'
alias pfpath='echo $FPATH | tr ":" "\n" | sort'
alias plpath='echo $LD_LIBRARY_PATH | tr ":" "\n" | sort'

# no command prepend for ls because we may use another ls alias later
alias ll='ls -Alq -F ${ls_colors}'
alias lld='ls -Aldq -F ${ls_colors}'
alias lrt='ls -lArtq -F ${ls_colors}'
alias lrtd='ls -lArtdq -F ${ls_colors}'
alias lrth='ls -lArtq -F ${ls_colors}|head -20'
alias lrtt='ls -lArtq -F ${ls_colors}|tail -20'
alias lla='ls -lAq -F ${ls_colors}'
alias lrta='ls -lrtAq -F ${ls_colors}'

alias grep='command grep ${grep_colors} -I'
alias grepr='command grep ${grep_colors} -Ir'
alias egrep='command grep ${grep_colors} -IE'
alias egrepi='command grep ${grep_colors} -Ii'
alias egrepr='command grep ${grep_colors} -IEr'
alias dusk='command du -sk ./*|sort -n'
alias dusmt='command du -sm ./* 2>/dev/null|sort -n|tail'
alias dusmcd='command test ${_dusmcd} || dusm; cd ${_dusmcd} && unset _dusmcd'

alias dfk='dfm -k'
# http://www.danielmiessler.com/study/lsof/
#alias lsofni='command lsof -nsRPi | egrepi -E'
#alias lsofi='command lsof -sRPi | egrepi -E'
alias lsofni='command lsof ${lsof_options} -nRPi | egrepi -E'
alias lsofi='command lsof ${lsof_options} -RPi | egrepi -E'
# alias psef='command ps -wwwef | grep -v grep | egrepi -E'
# alias psef='command ps -${PsWw}ef | grep -v grep | egrepi -E'
# alias psef='command ps -${Pseo} | grep -v -- grep | egrepi -E'
alias psev='command ps -e -o pid,vsz,comm= | sort -n -k 2'
alias vnstat='command vnstat -i'
alias topp='psef | /bin/grep -v -E -- "USER|pts/" | command sort -rk4 | command head -n 10'

alias version='eval ${version}'
alias tvm='command tail -20 /var/adm/messages'
alias scp='${scp}'
alias llcpio='echo "cpio -idmvu <file.cpio"'
alias nmon2disk='cd /tmp; command nmon -f -T -s60 -c480'
alias tar='command ${tar}'
alias purge10='command find . -mtime +10 -type f -exec unlink {} \;'
alias purge20='command find . -mtime +20 -type f -exec unlink {} \;'
alias purge30='command find . -mtime +30 -type f -exec unlink {} \;'
alias purge45='command find . -mtime +45 -type f -exec unlink {} \;'

alias tf='command tail -f'
alias ttf='command tail -n +1 -f'
alias t50='command tail -50'
alias h50='command head -50'
alias h1='command head -1'
alias hd='command hexedit'
alias he='command hexedit'
# alias trim="sed -e 's/^[[:space:]]*//g' -e 's/[[:space:]]*\$//g'"
# alias ltrim="sed -e 's/^[[:space:]]*//g'"
# alias rtrim="sed -e 's/[[:space:]]*\$//g'"
# alias vim='vim -u ${VIMRC}'
alias alais=alias
alias telent=telnet
alias more=less
alias wget="command wget ${wget_options}"
alias xl='xargs --show-limits'
fi

########
# MAIN ####################################################################################################################################
########
# lsof version: lsof < 4.8x = caca
if whichh lsof >/dev/null 2>&1; then
  LSOF_VERSION=$(lsof -v 2>&1 | ${awk} '$1 == "revision:" {print $NF}')
  floatCompare "${LSOF_VERSION} >= 4.80" && lsof_options='-o -o 0'
  floatCompare "${LSOF_VERSION} < 4.80" && lsof_options=''
fi

find -version 2>/dev/null | command grep GNU >/dev/null 2>&1 && GNU_FIND=true || GNU_FIND=false
$GNU_FIND && iname=iname

setColors
setDate
getWidth
setLanguage
# cygwin issue with xargs: environment is too large for exec
bashLoadFpath

if $TTY; then
  # always use Unicode box drawing characters when a UTF-8 locale is selected:
  NCURSES_NO_UTF8_ACS=1
  # LESSCHARSET=latin1
  LESSCHARSET=utf-8
  # LESS="-iRFfnr"
  LESS="-JMQRSi"
  alias less='less -JMQRSi'
  # LESS_IS_MORE issue with CYGWIN: when set, whatever the value, man colors are broken
  whichh less >/dev/null 2>&1 && LESS_IS_MORE=1 || LESS_IS_MORE=0

  # PERL libraries:
  PERL5LIB=${DIREXPLOIT}/share/rlwrap/filters
  [ -d "${DIREXPLOIT}/share/perl/${UNAME}.${bit}" ] && PERL5LIB=${PERL5LIB}:${DIREXPLOIT}/share/perl/${UNAME}.${bit}
  PERLLIB=${PERL5LIB}

  [ "${LOGNAME}" == "oracle" ] && ORACLE_VERSION=$(strings $(which oracle >/dev/null 2>&1) | ${awk} '/NLSRTL/ {print $3}')
  whichh vim >/dev/null 2>&1 && EDITOR=vim || EDITOR=vi
  VIM=${DIREXPLOIT}/etc/vim/after
  VIMRC=${DIREXPLOIT}/etc/vim/vimrc.vim
  unset VIMRUNTIME vimruntime VIM_VERSION vim_version
  EXINIT='set showmode'
  SCREENRC=${DIREXPLOIT}/etc/screenrc
  TMUXRC=${DIREXPLOIT}/etc/tmuxrc

  if [ "${BASH_VERSION}" ]; then
    HISTCONTROL=ignoreboth
    HISTTIMEFORMAT="%D %H:%M "
    HISTFILESIZE=1000
    HISTIGNORE="ls:ll:lrt:lrta:lla:lrth:lrtt"
    shopt -s histappend
    set -o emacs
    # http://www.thegeekstuff.com/2011/08/bash-history-expansion/
    set +o histexpand
  else
    # you seriously think you can survive with KSH88 and functions written for bash ? think twice...
    set -o vi
  fi
  # https://github.com/sickill/stderred/blob/master/README.md
  if [ -s "${DIREXPLOIT}/lib/${UNAME}.${KERNELV}.${bit}/libstderred.so" ] && (ldd "${DIREXPLOIT}/lib/${UNAME}.${KERNELV}.${bit}/libstderred.so" >/dev/null 2>&1); then
    LD_PRELOAD="${DIREXPLOIT}/lib/${UNAME}.${KERNELV}.${bit}/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
    STDERRED_ESC_CODE=${r}
    # STDERRED_BLACKLIST="^(bash|test.*)$"
    alias stderred='export LD_PRELOAD=${DIREXPLOIT}/lib/${UNAME}.${KERNELV}.${bit}/libstderred.so;echo export LD_PRELOAD=${LD_PRELOAD}'
  else
    unset LD_PRELOAD
    alias stderred='echo2 "libstderred.so NOT FOUND in ${DIREXPLOIT}/lib/${UNAME}.${KERNELV}.${bit}/"'
  fi
  ls --time-style="+%Y-%m-%d %H:%M:%S" >/dev/null 2>&1 && alias ls='ls --time-style="+%Y-%m-%d %H:%M:%S"'
  ls --color=auto >/dev/null 2>&1 && ls_colors='--color=auto'
  ls | command grep --color=auto . >/dev/null 2>&1 && grep_colors='--color=auto'

  case ${UNAME} in
  AIX)
    # using aliases for ls grep egrep means you're using Linux ported utils for AIX
    alias chmod='chmod -h'
    alias chown='chown -h'
    # alias vim='vim -i NONE -u ${VIMRC}'
    alias errptt='errpt -a | /bin/grep -E -- "LABEL:|Date/Time|^/"|more'
    alias lpath='echo export LIBPATH=$LIBPATH'
    alias plpath='echo $LIBPATH | tr ":" "\n" | sort'
    stty erase ^H
    (( LESS_IS_MORE != 1 )) && More="pg -n" && alias more="pg -n"
    # COLUMNS=9999
    ;;
  Linux)
    eval $(resize 2>/dev/null) 2>/dev/null
    alias errptt="dmesg"
    [ -f "/var/log/messages" ] && alias errptt="${awk} '{print \$4,\$5,\$6,\$7,\$8,\$9,\$10,\$11,\$12,\$13,\$14,\$15}' /var/log/messages | sed -e 's/\\[[0-9]*\\]:/:/' | sort | uniq | more"
    ;;
  SunOS)
    # Terminal too wide:
    stty columns 163
    eval $(resize 2>/dev/null) 2>/dev/null
    unalias grep egrep 2>/dev/null
    # /usr/ucb/ps -algxwww => F   UID   PID  PPID %C PRI NI   SZ  RSS    WCHAN S TT        TIME COMMAND
    # alias psef='/usr/ucb/ps -algxwww | /bin/grep -v -- grep | egrep'
    ;;
  CYGWIN*)
    unset LESS_IS_MORE
    ;;
  *)
    true
    ;;
  esac

  # bind word tabulations, tested on AIX/Linux[Suse|Fedora]
  # http://unix.stackexchange.com/a/35399/31585
  # http://www.softpanorama.org/Scripting/Shellorama/inputrc.shtml
  if bind 2>/dev/null; then
    # bind -p | egrep "del|backward|end|begining" to find out the current associations.
    # HOWTO find key sequences:
    # 1) CTRL+V then CHAR to show the real code, then replace ^[ by \e, then rebind it.
    # 2) od -c, type the key, then Enter, then Ctrl+D (033 = \e)
    # 3) Linux rlwrap: rlwrap -b '(){}[],+=&^%$#@\;|\`' -R -t dumb -r -pBlue -z ${DIREXPLOIT}/etc/rlwrap/rlwrap.jython.prompt.pl -a /bin/ksh
    # 4) AIX rlwrap  : rlwrap -b '(){}[],+=&^%$#@\;|\`' -R -t dumb -r -pBlue -z ${DIREXPLOIT}/etc/rlwrap/rlwrap.jython.prompt.pl /bin/ksh
    bind '"\eOD":backward-word' ; bind '"\eOC":forward-word'
    bind '"\e[1~":beginning-of-line' ; bind '"\e[4~":end-of-line'
    bind '"\^?": delete-char-backward' ; bind '"\e[3~": delete-char'
    # bind -f ${DIREXPLOIT}/etc/inputrc
    INPUTRC=${DIREXPLOIT}/etc/inputrc
  fi

  # $STY is best suited to determine if we are working inside screen or not
  # if [ -n "$WINDOW" -o "$TERM" == "screen" ]; then
  if [ "$STY" ]; then
    # screen: Each window in a `screen' session emulates a VT100 terminal, with some extra functions added.
    # The VT100 emulator is hard-coded, no other terminal types can be emulated.
    # And VT100s don't have Ctrl-Arrow keycodes. So we bind ALT-Arrow instead!
    bind '"\e\e[D": backward-word' ; bind '"\e\e[C": forward-word'
    # numeric keypad issue : http://www.mail-archive.com/screen-users@gnu.org/msg02355.html
    # bind '"\eOQ": "/"' ; bind '"\eOR": "*"' ; bind '"\eOS": "-"'                                      # BUT you still get issue for "+" which returns ","
    # => SOLUTION for numeric keypad : disable numeric keypad for application in Putty Terminal/Features: http://vim.wikia.com/wiki/PuTTY_numeric_keypad_mappings
  fi

  ORIGIN=$(who am i 2>/dev/null | ${awk} '{print substr($NF,2,(length($NF)-2))}')
  # DISPLAY=${ORIGIN}:0.0

  setPS1
  test $BASH_VERSINFO && (( BASH_VERSINFO < 3 )) && $Echo ${y} DATE "BASH_VERSINFO $BASH_VERSINFO is too old" "bash $BASH_VERSION will lead to some misinterpreted scripts" WARN
fi

############################################################## ENTITY ########################################################################
[ -s "${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${ENTITY}.sh" ] && . ${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${ENTITY}.sh
#============================================================= ENTITY =======================================================================#
set +a
