(set -o | grep allexport | grep on >/dev/null) && allexport=true || allexport=false
set -a

# https://remotemonitoringsystems.ca/time-zone-abbreviations.php
# echo EST5EDT >/etc/TZ
export TZ=`cat /etc/TZ`
# nvram get time_zone
# nvram set time_zone=`cat /etc/TZ`
# nvram commit

############################################################## profile ########################################################################
# echo "0.0.0.0/0 via 192.168.192.2" >/etc/sysconfig/network-scripts/route-eth0
# PATH=/opt/sbin:/opt/bin:/opt/usr/sbin:/opt/usr/bin:/bin:/usr/bin:/sbin:/usr/sbin:/jffs/sbin:/jffs/bin:/jffs/usr/sbin:/jffs/usr/bin:/mmc/sbin:/mmc/bin:/mmc/usr/sbin:/mmc/usr/bin
pathmunge /opt/usr/bin -f
pathmunge /opt/usr/sbin -f
pathmunge /opt/bin -f
pathmunge /opt/sbin -f
LD_LIBRARY_PATH=/opt/lib:/opt/usr/lib:/lib:/usr/lib:/jffs/lib:/jffs/usr/lib:/jffs/usr/local/lib:/mmc/lib:/mmc/usr/lib

############################################################## common ########################################################################
parallelJobs=4
remoteUser=root
defaultPassword=""
vim_version=704 #E319: Sorry, the command is not available in this version: exe "set t_cm=\<C-M>"|echo version|quit
VIM_VERSION=${vim_version}
vimruntime=/opt/share/vim/vim74
VIMRUNTIME=${vimruntime}
SSL_CERT_FILE=/opt/etc/ssl/certs/ca-certificates.pem

PROXY_local=""

############################################################## functions ########################################################################

############################################################## PLI ########################################################################

############################################################## TTY ########################################################################
if $TTY; then
  alias sshldo='command ssh -F ~/.ssh/ssh_config'
  alias sync2N5550='rsync -Wav --bwlimit=800 --progress /usr2/exploit/ root@scavenger.hd.free.fr:/raid/data/sources/root/'
  alias screen='screen -UxdRR -t ${HOSTNAME}'
  alias tmuxx='tmux a -t ldo || tmux new -s ldo "tmux source-file ${DIREXPLOIT}/etc/tmuxrc"'
  alias tmuxr='tmux source-file ${DIREXPLOIT}/etc/tmuxrc'

  alias help='alias | grep log; echo listhackers; echo wwhois; echo mountusb; echo umountusb'
  alias oplist='opkg list | grep'
  alias openssl='LD_LIBRARY_PATH= openssl'

  alias cdlog='cd /var/log; lrtt'
  alias n0log='grep local0.notice /var/log/messages'
  alias adlog='grep adblock /var/log/messages'
  alias initlog='grep entware_init /var/log/messages'
  alias tlog='tail -f /var/log/messages'
  alias plog='echo grep pixelserv /var/log/messages; grep pixelserv /var/log/messages'
  alias tplog='echo grep pixelserv /var/log/messages; tail -f /var/log/messages | grep pixelserv '
  alias pmlog='echo /opt/var/cache/pixelserv:;ls -l /opt/var/cache/pixelserv/;ls /var/log/messages*; egrep "missing|generated" /var/log/messages'
  alias tpmlog='echo /opt/var/cache/pixelserv:;ls -l /opt/var/cache/pixelserv/;ls /var/log/messages*;tail -f /var/log/messages | egrep "missing|generated"'

  alias crontabl='nvram get cron_jobs'
  alias crontabe='echo nvram get cron_jobs \>/tmp/crontab;nvram get cron_jobs >/tmp/crontab;echo vi /tmp/crontab;echo nvram set cron_jobs=\"\`cat /tmp/crontab\`\";echo nvram set aviad_changed_nvram=1;echo stopservice cron;echo startservice cron'
  
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

fi

#=========================================================================================================================================#
! ${allexport} && set +a && unset allexport
echo "kong  : https://www.myopenrouter.com/downloads/dd-wrt-r7000r7000p"
echo "ddup --flash-remote http://www.desipro.de/ddwrt/K3-AC-Arm/dd-wrt.K3_R7000.chk"
echo "update: ddup --flash-latest"
