#!/bin/sh
set -a
case $- in
  *i*) TTY=true;;
  *) TTY=false;;
esac

r=$(echo -e "\033[0;31m")
g=$(echo -e "\033[0;32m")
b=$(echo -e "\033[0;34m")
w=$(echo -e "\033[0;37m")
y=$(echo -e "\033[0;33m")
m=$(echo -e "\033[0;35m")
c=$(echo -e "\033[0;36m")
k=$(echo -e "\033[0;90m")
HIGH=$(echo -e "\e[1m")

bell=$(echo -e "\007")
blink=$(echo -e "\033[5m")
rev=$(echo -e "\033[7m")
ul=$(echo -e "\033[4m")
END=$(echo -e "\e[0m")

if $TTY; then
command unset LD_PRELOAD ls_colors grep_colors
command unalias alias id ls rm cp mv du df ps vim tar ssh scp more less grep lsof egrep which whichh uname screen whoami hostname psef 2>/dev/null
export PATH=/opt/sbin:/opt/bin:/opt/usr/sbin:/opt/usr/bin:/bin:/usr/bin:/sbin:/usr/sbin:/jffs/sbin:/jffs/bin:/jffs/usr/sbin:/jffs/usr/bin:/mmc/sbin:/mmc/bin:/mmc/usr/sbin:/mmc/usr/bin
export LD_LIBRARY_PATH=/opt/lib:/opt/usr/lib:/lib:/usr/lib:/jffs/lib:/jffs/usr/lib:/jffs/usr/local/lib:/mmc/lib:/mmc/usr/lib
export SSL_CERT_FILE=/opt/etc/ssl/certs/ca-certificates.pem

ls -q >/dev/null 2>&1 && ls_option=q
ls --time-style="+%Y-%m-%d %H:%M:%S" >/dev/null 2>&1 && ls_time_style='--time-style="+%Y-%m-%d %H:%M:%S"'
ls --color=auto>/dev/null 2>&1 && ls_colors='--color=auto'
grep --color=auto >/dev/null 2>&1 && grep_colors='--color=auto'
ps -www >/dev/null 2>&1 && PsWw=www

alias br='sync; bashLoadFpath'

alias cd_exp='cd ${DIREXPLOIT}'
alias cdexp='cd ${DIREXPLOIT}'
alias cdi='cd /etc/init.d'
alias cd2='cd /etc/rc.d/rc2.d'

alias path='echo export PATH=$PATH'
alias fpath='echo export FPATH=$FPATH'
alias ppath='echo $PATH | tr ":" "\n" | sort'
alias lpath='echo export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}'
alias plpath='echo ${LD_LIBRARY_PATH} | tr ":" "\n" | sort'

alias ll="ls -Al${ls_option} -F ${ls_colors} ${ls_time_style}"
alias lld="ls -Ald${ls_option} -F ${ls_colors} ${ls_time_style}"
alias lrt="ls -lArt${ls_option} -F ${ls_colors} ${ls_time_style}"
alias lrtd="ls -lArtd${ls_option} -F ${ls_colors} ${ls_time_style}"
alias lrth="ls -lArt${ls_option} -F ${ls_colors} ${ls_time_style}|head -20"
alias lrtt="ls -lArt${ls_option} -F ${ls_colors} ${ls_time_style}|tail -20"
alias lla="ls -lA${ls_option} -F ${ls_colors} ${ls_time_style}"
alias lrta="ls -lrtA${ls_option} -F ${ls_colors} ${ls_time_style}"

alias grep='grep ${grep_colors} -I'
alias grepr='grep ${grep_colors} -Ir'
alias egrep='grep ${grep_colors} -IE'
alias egrepi='grep ${grep_colors} -Ii'
alias egrepr='grep ${grep_colors} -IEr'
alias dusk='du -sk ./*|sort -n'
alias dusmt='du -sm ./* 2>/dev/null|sort -n|tail'
alias dusmcd='test ${_dusmcd} || dusm; cd ${_dusmcd} && unset _dusmcd'

alias dfk='df -k'
alias dfm='df -m'
# http://www.danielmiessler.com/study/lsof/
#alias lsofni='lsof -nsRPi | egrepi -E'
#alias lsofi='lsof -sRPi | egrepi -E'
alias lsofni='lsof ${lsof_options} -nRPi | egrepi -E'
alias lsofi='lsof ${lsof_options} -RPi | egrepi -E'
alias psef='ps -${PsWw}ef | grep -v grep | egrepi -E'
# alias psef='ps -${Pseo} | grep -v -- grep | egrepi -E'
alias psev='ps -e -o pid,vsz,comm= | tail +2 | sort -n -k 2'
alias vnstat='vnstat -i'
alias topp='psef | /bin/grep -v -E -- "USER|pts/" | sort -rk4 | head -n 10'

alias version='eval ${version}'
alias tvm='tail -20 /var/adm/messages'
alias scp='${scp}'
alias llcpio='echo "cpio -idmvu <file.cpio"'
alias nmon2disk='cd /tmp; nmon -f -T -s60 -c480'
alias tar='${tar}'
alias purge10='find . -mtime +10 -type f -exec unlink {} \;'
alias purge20='find . -mtime +20 -type f -exec unlink {} \;'
alias purge30='find . -mtime +30 -type f -exec unlink {} \;'
alias purge45='find . -mtime +45 -type f -exec unlink {} \;'

alias tf='tail -f'
alias ttf='tail -n +1 -f'
alias t50='tail -50'
alias h50='head -50'
alias h1='head -1'
alias hd='hexedit'
alias he='hexedit'
# alias trim="sed -e 's/^[[:space:]]*//g' -e 's/[[:space:]]*\$//g'"
# alias ltrim="sed -e 's/^[[:space:]]*//g'"
# alias rtrim="sed -e 's/[[:space:]]*\$//g'"
# alias vim='vim -u ${VIMRC}'
alias alais=alias
alias telent=telnet
alias more=less
alias wget="wget ${wget_options}"

alias help='alias | grep log; echo listhackers; echo wwhois; echo mountusb; echo umountusb'
alias oplist='opkg list | grep'
alias openssl='LD_LIBRARY_PATH= openssl'

alias n0log='grep local0.notice /var/log/messages'
alias adlog='grep adblock /var/log/messages'
alias initlog='grep entware_init /var/log/messages'
alias tlog='tail -f /var/log/messages'
alias plog='echo grep pixelserv /var/log/messages; grep pixelserv /var/log/messages'
alias tplog='echo grep pixelserv /var/log/messages; tail -f /var/log/messages | grep pixelserv '
alias pmlog='echo /opt/var/cache/pixelserv:;ls -l /opt/var/cache/pixelserv/;ls /var/log/messages*; egrep "missing|generated" /var/log/messages'
alias tpmlog='echo /opt/var/cache/pixelserv:;ls -l /opt/var/cache/pixelserv/;ls /var/log/messages*;tail -f /var/log/messages | egrep "missing|generated"'
alias snort='snort --daq-dir /opt/lib/daq'

if [ $(grep password /var/log/messages | wc -l) -gt 10 ]; then
  echo "${y}WARNING:${END} Hacking via SSH in progress... ${r}$(awk '/password/ {print $NF}' /var/log/messages* | cut -f1 -d: | sort | uniq|wc -l)${END} single IP so far!"
  echo ${k}"awk '/password/ {print \$NF}' /var/log/messages* | cut -f1 -d: | sort | uniq"${END}
  echo ${k}"grep password /var/log/messages | tail -20"${END}
  grep password /var/log/messages | tail -20
fi

listhackers() {
awk '/password/ {print $NF}' /var/log/messages* | cut -f1 -d: | sort | uniq >/tmp/listhackers.log
wwhois /tmp/listhackers.log
}

wwhois() {
# whois $1 |egrep "descr:|abuse-mailbox:|route:"
if [ -n "$1" ]; then
  while read ip; do
    whois -H $ip | egrep -m 1 "descr:" | sed "s/descr:/$ip\t/g"
  done<$1
else
  whois -H $1 | egrep -m 1 "descr:" | sed "s/descr:/$1\t/g"
fi
# nmap -sS $1
}

mountusb() {
# dmesg | grep "Attached SCSI removable disk"
echo "mount -o rw -t usbfs /dev/sda1 /mnt"
mount -o rw -t usbfs /dev/sda1 /mnt/sda1
hdparm -tT  /dev/sda1
ll /mnt/sda1/
}

umountusb() {
umount /mnt/sda1
}

fi

service() {
services="privoxy dnsmasq lighttpd pixelserv"
arg="${2:-check}"
case $1 in
pixelserv)
  [ "$arg" == "check" ] && psef pixelserv && lsofni pixelserv && ls -l /opt/var/cache/pixelserv/
  [ "$arg" == "log" ] && echo "tlog clog plog pmlog"
  [ "$arg" == "stop" ] && /opt/etc/init.d/S80pixelserv-tls stop && killall pixelserv-tls
  [ "$arg" == "start" ] && ! (psef pixelserv) && echo "/opt/etc/init.d/S80pixelserv-tls stop" && /opt/etc/init.d/S80pixelserv-tls start
  [ "$arg" == "restart" ] && /opt/etc/init.d/S80pixelserv-tls stop && /opt/etc/init.d/S80pixelserv-tls start && psef pixelserv
  ;;
privoxy)
  [ "$arg" == "check" ] && psef privoxy
  [ "$arg" == "log" ] && echo tail -f /var/log/privoxy/logfile && tail -f /var/log/privoxy/logfile
  [ "$arg" == "stop" ] && stopservice privoxy && killall privoxy
  [ "$arg" == "start" ] && ! (psef privoxy) && echo "privoxy /tmp/privoxy.conf &" && startservice privoxy
  [ "$arg" == "restart" ] && stopservice privoxy && startservice && psef privoxy
  ;;
dnsmasq)
  [ "$arg" == "check" ] && psef dnsmasq
  [ "$arg" == "log" ] && psef dnsmasq
  [ "$arg" == "stop" ] && stopservice dnsmasq && killall dnsmasq
  [ "$arg" == "start" ] && ! (psef dnsmasq) && startservice dnsmasq && psef dnsmasq
  [ "$arg" == "restart" ] && stopservice dnsmasq && startservice dnsmasq && psef dnsmasq
  # dnsmasq -u root -g root --conf-file=/tmp/dnsmasq.conf --cache-size=1500 --dhcp-option=252,"http://config.privoxy.org/wpad.dat"
  # dnsmasq -u root -g root --conf-file=/tmp/dnsmasq.conf --cache-size=1500 --dhcp-option=252,"\" \""
  ;;
lighttpd)
  [ "$arg" == "check" ] && psef lighttpd
  [ "$arg" == "log" ] && echo /var/log/lighttpd/logs/: && ls -l /var/log/lighttpd/logs/ && tail -4 /var/log/lighttpd/logs/lighttpd.error.log
  [ "$arg" == "stop" ] && killall lighttpd
  [ "$arg" == "start" ] && ! (pidof lighttpd >/dev/null) && echo "lighttpd -f /jffs/lighttpd/lighttpd.conf start" && (LD_LIBRARY_PATH= lighttpd -f /jffs/lighttpd/lighttpd.conf start || tail -4 /var/log/lighttpd/logs/lighttpd.error.log)
  [ "$arg" == "restart" ] && (killall lighttpd; LD_LIBRARY_PATH= lighttpd -f /jffs/lighttpd/lighttpd.conf start || tail -4 /var/log/lighttpd/logs/lighttpd.error.log)
  ;;
*)  echo "usage: ${HIGH}service${END} ${services} ${k}[check|stop|start|restart|log]${END}" ;;
esac
}

set +a

