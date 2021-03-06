#NO SHEBANG
#!/usr/bin/env bash
export PROFILE_VERSION=4.0.2
unalias alias unalias set unset alias id ls rm cp mv du df ps vi vim tar ssh scp more less grep egrep lsof which uname screen whoami hostname psef 2>/dev/null
unset declare LD_PRELOAD ls_colors grep_colors
export PATH=/usr/sbin:/usr/bin:/sbin:/bin
[ "$(uname -s)" = "AIX" ] && PATH=/usr/bin:/etc:/usr/sbin:/usr/ucb:/usr/bin/X11:/sbin:/usr/ccs/bin:/usr/dt/bin:/usr/opt/perl5/bin:/opt/freeware/bin:/opt/freeware/sbin:/usr/local/sbin:/usr/local/bin:/usr/lib/instl:/usr/java5/jre/bin:/usr/java5/bin

# TODO: do something with LIBDIR_NAME
# http://tldp.org/LDP/abs/html/internalvariables.html
#! test "${BASH_VERSION}" && echo "THIS PROFILE WORKS ONLY WITH BASH. You got 5 secs to hit CTRL+C before exit 99..." 2>&1 && sleep 5 && exit 99
# Re-init the profile. Totally. Remember this script is meant to be your profile. Forget ~/.profile and ~/.barhrc
. /etc/profile 2>/dev/null
[ -s ~/.profile ] && . ~/.profile 2>/dev/null
set -a

# The easiest way for the unit tests to know whether or not they are running on a terminal is to test of the stdio file descritors refer to a terminal:
# [ -t 0 ] && TTY=true || TTY=false
# line bellow works for ash/busybox:
#[[ $- = *i* ]] && TTY=true || TTY=false
#foolproof interactive detect:
[ "$-" = "${-%i*}i${-#*i}" ] && TTY=true || TTY=false

# BASENAME=$(basename $0)
# DIRNAME=$([ -s "./$0" ] && pwd || dirname $0)
# SCRIPT=${BASENAME%\.*}

################################################################### profile ####################################################################
if [ -n "$BASH_SOURCE" ]; then
  # TODO: create install profile: sh -c "$(curl -fsSL https://raw.github.com/audioscavenger/profile/master/tools/install.sh)"
  DIREXPLOIT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P)"
  shell=bash
elif [ -n "$ZSH_VERSION" ]; then
  # install zsh profile: sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  setopt function_argzero
  [ ! -e "$PWD/$0" ] && DIREXPLOIT=`dirname "$0"` || DIREXPLOIT=`dirname "$PWD/$0"`
  DIREXPLOIT=`realpath ${DIREXPLOIT}`
  shell=zsh
# this creates an error with sh and dash:
#elif eval '[ -n "${.sh.file} 2>/dev/null" ]' 2>/dev/null; then
elif [ -n "${KSH_VERSION}" ]; then
  eval 'DIREXPLOIT=`dirname ${.sh.file}`'
  shell=ksh
  alias local=typeset
else
  echo 1>&2 "Unsupported shell. Please use bash, ksh or zsh." && sleep 5 && exit 2
fi

#set SCRIPT=`readlink -f "$0"` && set BASENAME=`basename "$SCRIPT"`
#set DIREXPLOIT=`dirname "$SCRIPT"`

# ENTITY = touch ~/.entity.NAME; if not exist, ENTITY=$HOSTNAME
HOSTNAME=$(hostname) && HOSTNAME=${HOSTNAME%%\.*}
ENTITY=$(ls ~/.entity.* 2>/dev/null) && ENTITY=${ENTITY##*.} || ENTITY=$HOSTNAME
Debug=false
Verbose=false
# par defaut on affiche tout bien sur... Echo est une fonction
# Echo=NOEcho
Echo=Echo
PAUSE=false

umask 0002
UNAME=$(uname -s)
MARCH=$(uname -m)
[ "${MARCH#*64}" != "${MARCH}" -o "${MARCH#*ARMv8}" != "${MARCH}" ] && bit=64
REVISION=$(uname -r)
KERNELV=$(uname -r | cut -c-3)
OLDAIX=false
[ -z "${LOGNAME}" ] && LOGNAME=$(whoami)
bit=32

############################################################# KSH FPATH emulation ABANDONED will be removed in version 4.1.0 ###################
# TODO: check 4.0.0 still works on cygwin
# https://groups.google.com/forum/#!topic/mintty-discuss/8mCkdAPD-sE
# xargs --show-limits
[ "${TERM}" = "cygwin" ] && FPATH_EXCLUDED="APRIA|AIX|apache|CNETI|crossCompiler|PLI|SunOS|THECUS|was|Linux" || FPATH_EXCLUDED="none"
#unset FPATH; for dir in $(ls -d ${DIREXPLOIT}/FPATH/* | egrep -v "${FPATH_EXCLUDED}" 2>/dev/null); do FPATH=${FPATH}${FPATH:+:}${dir}; done

# INFO: the SunOS "which" command always returns 0; make sure SunOS in the PATH
# INFO: "which" command is actually a builtin in zsh, make sure to prepend "which" with command
# FPATH folder is renamed to PATH because it doesn't contain functions anymore
for _folder in $(ls -d ${DIREXPLOIT}/PATH/* 2>/dev/null); do
  case ${_folder##*/} in
  AIX) [ ${UNAME} != AIX ] && continue ;;
  Linux) [ ${UNAME} != Linux ] && continue ;;
  SunOS) [ ${UNAME} != SunOS ] && continue ;;
  esac
  PATH=${_folder}:$PATH
done

#if test "${BASH_VERSION}"; then
#  bashLoadFpath
#  # set -o pipefail     # Unavailable with BASH_VERSINFO < 3, and a hassle to handle later in the other functions. Abandoned.
#fi
# 4.0.0--------------------------

############################################################# KSH FPATH emulation ##############################################################
if [ "${shell}" != "ksh" ]; then
  bashLoadFunc() {
  # http://linux.about.com/library/cmd/blcmdl1_bash.htm
  # disable expand_aliases coz some functions have an alias name so eval will return an error if the alias exists and expand_aliases=on. Solution is to declare the function such as "function funcname ()" in the script, instead of just "funcname ()"
  # 20190126: https://unix.stackexchange.com/questions/375156/typeset-in-ksh93-not-working-as-expected
  # aliasing local and function declaration seems genius but then quid of this bashLoadFunc?
  ! (($#)) && return 99
  shopt -u expand_aliases 2>/dev/null
  eval $1 '() { unalias '$1' 2>/dev/null ; . '$2' ; '$1' "$@" ; return $? ; }'
  export $1
  shopt -s expand_aliases 2>/dev/null
  # enable aliases
  }

  for _func in ${DIREXPLOIT}/FPATH/missing/*; do command which ${_func##*/} >/dev/null || bashLoadFunc ${_func##*/} $_func; done
  for _func in ${DIREXPLOIT}/FPATH/profile/*; do bashLoadFunc ${_func##*/} $_func; done
    
else
  # zsh incompatible with FPATH
  export FPATH=${DIREXPLOIT}/FPATH/ksh:${DIREXPLOIT}/FPATH/missing:${DIREXPLOIT}/FPATH/profile
  [ -d "${DIREXPLOIT}/FPATH/${UNAME}" ] && FPATH=${DIREXPLOIT}/FPATH/${UNAME}:$FPATH
fi

############################################################ compiled binaries PATH ############################################################

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

################################################################ ENTITY ########################################################################
# Because of specific path issues, ENTITY profile has to be loaded twice. Once here, once at the end
# TODO: separate profile.${HOSTNAME}.sh into profile.${HOSTNAME}.sh + path.${HOSTNAME}.sh
[ -s "${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${HOSTNAME}.sh" ] && . ${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${HOSTNAME}.sh >/dev/null 2>&1

LF="\n"
patterner=${DIREXPLOIT}/etc/patterner.awk
[ -x ${DIREXPLOIT}/etc/timestamp.pl ] && timestamp=${DIREXPLOIT}/etc/timestamp.pl || timestamp=cat
# /etc/redhat-release /etc/debian_version /etc/issue
version='$Echo ${W} DATE "${UNAME} ${KERNELV} ${bit} ${MACHTYPE}" "${HOSTNAME} $(cat /etc/*release 2>/dev/null|head -1) $(uname -rms) ${BASH_VERSION:++BASH $BASH_VERSION}" ${PROFILE_VERSION}'

################################################### special aliases and missing binaries #######################################################

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
psef='command ps -${Pseo} | command grep -v -- grep | command grep -E'
lsofni='command lsof ${lsof_options} -nRPi'
lsofi='command lsof ${lsof_options} -RPi'

# wget_options and WGETRC can be set differently according to what's in ${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${ENTITY}.sh
wget_options='--no-check-certificate -e robots=off -e cache=off -e prefer-family=IPv4 --restrict-file-names=windows --content-disposition --random-wait --user-agent="Mozilla/5.0"'
wget="command wget ${wget_options}"
WGETRC=${DIREXPLOIT}/etc/wgetrc
no_proxy=${no_proxy:-".local,.localdomain,proxy,localhost,127.0.0.1,localaddress,.localdomain.com,10.*,172.*,192.168.*"}

# https://www.biostars.org/p/63816/
# INFO: accessing exported functions with parallel is ONLY possible with SHELL=.../bash
# http://www.gnu.org/software/parallel/parallel_tutorial.html
parallelJobs=12
remoteUser=root
remoteProfile="{ . ${DIREXPLOIT}/profile.sh >/dev/null 2>&1; }"
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
  RAM=$(lsattr -HE -l sys0 -a realmem | tail -1 | awk '{print $2}')
  KERNELV=$(oslevel | cut -c-3)
  bit=$(getconf KERNEL_BITMODE)
  typeset -lL1 bear 2>/dev/null
  rcDir=/etc/rc.d/rc2.d
  floatCompare "$KERNELV < 6.1" && OLDAIX=true
  $OLDAIX && Pseo=ef
  # this test would be false on an OLDAIX: find $DIREXPLOIT/FPATH -type d -print0 | xargs -0 ls -d
  ;;
Linux)
  echo=${print}
  PsWw=www
  Pseo=${PsWw}${Pseo}
  # alias psef='/usr/sysv/bin/ps -${PsWw}eA -o user,pid,ppid,pcpu,pmem,rss,vsz,time,tty,args | sort -k10 -k 3 -k2 | egrepi -E'
  ;;
SunOS)
  # http://wiki.bash-hackers.org/commands/builtin/printf
  # Solaris version of /bin/echo is equivalent to: printf "%b\n" "$*"
  # SunOS: useless to try to handle anything aroung grep or egrep; let's use the functions instead: so unalias them as well
  Pseo="eo user,pid,ppid,pcpu,pcpu,etime,tty,time,args"
  command which nawk >/dev/null 2>&1 && awk=`command which nawk 2>/dev/null`
  typeset -lL1 bear 2>/dev/null
  # /usr/ucb/ps -algxwww => F   UID   PID  PPID %C PRI NI   SZ  RSS    WCHAN S TT        TIME COMMAND
  psef='/usr/ucb/ps -algxwww | /bin/grep -v -- grep | egrep'
  ;;
esac

Cr=0
CR=0
NbKO=0
## this can take quite some time on VM:
# FQDN=$(getDNS ${HOSTNAME})
FQDN=${HOSTNAME}

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

################################################################### TTY ########################################################################
if $TTY; then
# infocmp xterm-256color >xterm-256color.tic && tic xterm-256color.tic ==> /usr/share/[lib/]terminfo/x/xterm-256color
if [ "${TERM}" != "cygwin" ]; then
  CURRENT_TERM=$TERM
  TERM=xterm-256color # TERM has to be temporarily forced to 256 for tput to work
  tput colors >/dev/null 2>&1 && [ "$(tput colors)" = "256" ] && TERM=xterm-256color || TERM=$CURRENT_TERM
fi

. ${DIREXPLOIT}/.aliasrc

fi

########
# MAIN #########################################################################################################################################
########
# lsof version: lsof < 4.8x = issues
if command which lsof >/dev/null 2>&1; then
  LSOF_VERSION=`lsof -v 2>&1 | awk '$1 == "revision:" {print $NF}'`
  floatCompare "${LSOF_VERSION} >= 4.80" && lsof_options='-o -o 0'
fi

find -version 2>/dev/null | command grep GNU >/dev/null 2>&1 && GNU_FIND=true || GNU_FIND=false
$GNU_FIND && iname=iname

setDate
setLanguage
setWidth

if $TTY; then

  # always use Unicode box drawing characters when a UTF-8 locale is selected:
  #NCURSES_NO_UTF8_ACS=0
  unset NCURSES_NO_UTF8_ACS
  # LESSCHARSET=latin1
  LESSCHARSET=utf-8
  # LESS="-iRFfnr"
  LESS="-JMQRSi"
  alias less='less -JMQRSi'
  # LESS_IS_MORE issue with CYGWIN: when set, whatever the value, man colors are broken
  command which less >/dev/null 2>&1 && LESS_IS_MORE=1 || LESS_IS_MORE=0

  # PERL libraries:
  PERL5LIB=${DIREXPLOIT}/share/rlwrap/filters
  [ -d "${DIREXPLOIT}/share/perl/${UNAME}.${bit}" ] && PERL5LIB=${PERL5LIB}:${DIREXPLOIT}/share/perl/${UNAME}.${bit}
  PERLLIB=${PERL5LIB}

  [ "${LOGNAME}" = "oracle" ] && ORACLE_VERSION=$(strings $(command which oracle >/dev/null 2>&1) | awk '/NLSRTL/ {print $3}')
  command which vim >/dev/null 2>&1 && EDITOR=vim || EDITOR=vi
  unset VIMRUNTIME vimruntime VIM_VERSION vim_version
  # TODO: decide upon which condition triggers the use of vim/after
  #VIM=${DIREXPLOIT}/etc/vim/after
  VIMRC=${DIREXPLOIT}/etc/vim/vimrc.vim
  EXINIT='set showmode'
  SCREENRC=${DIREXPLOIT}/etc/screenrc
  tmux -V 2>/dev/null | grep -q 2\.1 && TMUXRC=${DIREXPLOIT}/etc/tmuxrc.2.1 || TMUXRC=${DIREXPLOIT}/etc/tmuxrc.2.8
  alias tmux='command tmux -f $TMUXRC'

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
    alias vim='vim -i NONE -u ${VIMRC}'
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
    [ -f "/var/log/messages" ] && alias errptt="awk '{print \$4,\$5,\$6,\$7,\$8,\$9,\$10,\$11,\$12,\$13,\$14,\$15}' /var/log/messages | sed -e 's/\\[[0-9]*\\]:/:/' | sort | uniq | more"
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
  if [ "${BASH_VERSION}" ]; then
    HISTCONTROL=ignoreboth
    HISTTIMEFORMAT="%D %H:%M "
    HISTFILESIZE=1000
    HISTIGNORE="ls:ll:lrt:lrta:lla:lrth:lrtt"
    shopt -s histappend
    # http://www.thegeekstuff.com/2011/08/bash-history-expansion/
    set +o histexpand
    set -o emacs

    if type bind >/dev/null 2>&1; then
    # bind -p | egrep "del|backward|end|begining" to find out the current associations.
    # HOWTO find key sequences:
    # 0) cat
    # 1) CTRL+V then CHAR to show the real code, then replace ^[ by \e, then rebind it.
    # 2) od -c, type the key, then Enter, then Ctrl+D (033 = \e)
    # 3) Linux rlwrap: rlwrap -b '(){}[],+=&^%$#@\;|\`' -R -t dumb -r -pBlue -z ${DIREXPLOIT}/etc/rlwrap/rlwrap.jython.prompt.pl -a /bin/ksh
    # 4) AIX rlwrap  : rlwrap -b '(){}[],+=&^%$#@\;|\`' -R -t dumb -r -pBlue -z ${DIREXPLOIT}/etc/rlwrap/rlwrap.jython.prompt.pl /bin/ksh
    bind '"\eOD":backward-word' ; bind '"\eOC":forward-word'
    bind '"\e[1~":beginning-of-line' ; bind '"\e[4~":end-of-line'
    bind '"\^?": delete-char-backward' ; bind '"\e[3~": delete-char'
    INPUTRC=${DIREXPLOIT}/etc/inputrc

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
    fi
  elif type bindkey >/dev/null 2>&1; then
    . ${DIREXPLOIT}/etc/inputrc.zsh
  else
    set -o vi
  fi

  ORIGIN=$(who am i 2>/dev/null | awk '{print substr($NF,2,(length($NF)-2))}')
  # DISPLAY=${ORIGIN}:0.0

  setColors
  setPS1
  test $BASH_VERSINFO && (( BASH_VERSINFO < 3 )) && $Echo ${y} DATE "BASH_VERSINFO $BASH_VERSINFO is too old" "bash $BASH_VERSION will lead to some misinterpreted scripts" WARN
fi

################################################################ ENTITY ########################################################################
[ -s "${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${ENTITY}.sh" ] && . ${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${ENTITY}.sh
#=============================================================== ENTITY =======================================================================#

set +a
