#!/usr/bin/env bash
# ! [ "${BASH_VERSION}" ] && return 99  # one day or another this profile will refuse KSH and forever
# BASENAME=$(basename $0)
# DIRNAME=$([ -s "./$0" ] && pwd || dirname $0)
# SCRIPT=${BASENAME%\.*}
(set -o | grep allexport | grep on >/dev/null) && allexport=true || allexport=false
set -a
# echo load ubuntu

############################################################## profile ########################################################################
ENTITY=UBUNTU
Debug=false
Verbose=false

############################################################## common ########################################################################
remoteDIREXPLOIT="~/exploit"
srvList=${DIREXPLOIT}/etc/ENTITY/${ENTITY}/matrice.servers.list.txt
ipList=${DIREXPLOIT}/etc/ENTITY/${ENTITY}/matrice.IP.list.txt
parallelJobs=4
pingTimeout=1
sshTimeout=2
masters="N5550"
remoteUser=root
remoteProfile=" . ${DIREXPLOIT}/profile.sh >/dev/null 2>&1 "
remoteProfileLight=" export FPATH=${FPATH}; export PATH=$PATH; setDate; setColors "
ssh=${ssh:-'ssh -A -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no -o ServerAliveInterval=100'}
remoteSSH="command ${ssh} -o PreferredAuthentications=publickey -o ConnectTimeout=${sshTimeout} -qx -l ${remoteUser} -T"
commandSSH="command ${ssh} -qx -T"
productDir=/raid/data/module
mainRepoDir=/usr2/datas/export_lecture/stdpackages
repoDir=/usr2/stdpackages
instancesRootDir=/raid/data/share/webs
defaultPassword="defaultPassword"
defaultDomain="defaultDomain.com"
defaultORG="N5550"
defaultLOC="PARIS"
defaultST="IDF"
defaultCO="FR"
defaultKeyalg=rsa
defaultKeysize=2048

LANGUAGE="en_US"
LANGUAGE_TYPE="utf|8859"
#TZ="Europe/Paris"
LC_ALL=en_US.UTF-8

# PROXY_ENTITY="192.168.0.100:3128"
# srcIP_default="192.168.0.*"
no_proxy=".lan,.local,.localdomain,proxy,localhost,127.0.0.1,localaddress,.localdomain.com,192.168.*"
default_proxy_user=""
default_proxy_password=""
WGETRC=${DIREXPLOIT}/etc/wgetrc

httpConfd=/etc/httpd/conf.d
httpHtml=/var/www/html
mysqlCnfDir=${DIREXPLOIT}/etc/ENTITY/${ENTITY}
mysqldPort=3306

############################################################## functions ########################################################################

############################################################## PLI ########################################################################

############################################################## functions ########################################################################

function resetPerm() {
sudo chown -R apache:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
}


############################################################## TTY ########################################################################
if $TTY; then
  # For non-root users, add the current directory to the search path:
  if [ ! "$(id -u)" = "0" ]; then
   pathmunge . after
  fi

  # bind '"\e[1~": beginning-of-line'
  # bind '"\e[4~": end-of-line'
  # bind '"\eOC":forward-word'
  # bind '"\eOD":backward-word'
  # bind '"\e[3~": delete-char'
  # bind '"\C-?": backward-delete-char'

  alias cdconf='cd /etc/apache2'
  alias cdhtml='cd /var/www/html'
  
  alias htrestart='sudo systemctl restart apache2'
  alias htreload='sudo systemctl reload apache2'
  alias htcheck='sudo systemctl status apache2.service'
  
  alias dbstart='sudo systemctl start mysql'
  alias dbrestart='sudo systemctl restart mysql'
  alias dbstop='sudo systemctl stop mysql'
  alias dbcheck='sudo systemctl status mysql.service'
  
  alias sshrestart='sudo service ssh reload'
fi

#=========================================================================================================================================#
# echo path3=$PATH
[ -s "${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${HOSTNAME}.sh" ] && . ${DIREXPLOIT}/etc/ENTITY/${ENTITY}/profile.${HOSTNAME}.sh
# echo path4=$PATH
! ${allexport} && set +a && unset allexport
# echo end ubuntu
showLogon
