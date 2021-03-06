https://ownyourbits.com/2017/02/18/squeeze-disk-space-on-a-debian-system/

First, we want to remove those deb packages that get cached every time we do apt-get install.
apt-get clean

Cleaning up of partial package:
sudo apt autoclean

Also, the system might keep packages that were downloaded as dependencies but are not needed anymore. We can get rid of them with
apt-get autoremove

To clean those configurations from removed packages, we can use
dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs --no-run-if-empty sudo dpkg --purge

If now we want to inspect what packages are consuming the most space, we can type
dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n
# 46959   linux-modules-4.4.0-1077-aws
# 46993   linux-modules-4.4.0-1079-aws
# 47017   linux-modules-4.4.0-1083-aws
# 47022   linux-modules-4.4.0-1084-aws
# 47022   linux-modules-4.4.0-1085-aws
# 47022   linux-modules-4.4.0-1087-aws
# 47032   linux-modules-4.4.0-1088-aws
# 47136   linux-modules-4.4.0-1081-aws
# 54035   linux-image-4.4.0-1047-aws
# 54050   linux-image-4.4.0-1050-aws
# 54508   linux-image-4.4.0-1052-aws
# 54550   linux-image-4.4.0-1054-aws
# 54782   linux-image-4.4.0-1055-aws
# 54783   linux-image-4.4.0-1057-aws
# 54805   linux-image-4.4.0-1075-aws
# 54872   linux-image-4.4.0-1060-aws
# 54873   linux-image-4.4.0-1061-aws
# 54906   linux-image-4.4.0-1062-aws
# 54935   linux-image-4.4.0-1066-aws
# 54937   linux-image-4.4.0-1065-aws
# 54948   linux-image-4.4.0-1069-aws
# 54962   linux-image-4.4.0-1070-aws
# 54985   linux-image-4.4.0-1072-aws
# 54993   linux-image-4.4.0-1074-aws
# 60625   linux-modules-4.15.0-1044-aws
# 61388   libllvm8
# 68290   mariadb-server-10.0
# 70281   linux-aws-headers-4.4.0-1047
# 70573   linux-aws-headers-4.4.0-1088

http://ask.xmodulo.com/remove-kernel-images-ubuntu.html
First, check what kernel image(s) are installed on your system.
dpkg --list | grep linux-image
dpkg --list | grep linux-headers 
# ii  linux-image-4.15.0-1044-aws           4.15.0-1044.46                                           amd64        Linux kernel image for version 4.15.0 on 64 bit x86 SMP
# ii  linux-image-4.4.0-1047-aws            4.4.0-1047.56                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1050-aws            4.4.0-1050.59                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1052-aws            4.4.0-1052.61                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1054-aws            4.4.0-1054.63                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1055-aws            4.4.0-1055.64                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1057-aws            4.4.0-1057.66                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1060-aws            4.4.0-1060.69                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1061-aws            4.4.0-1061.70                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1062-aws            4.4.0-1062.71                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1065-aws            4.4.0-1065.75                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1066-aws            4.4.0-1066.76                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1069-aws            4.4.0-1069.79                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1070-aws            4.4.0-1070.80                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1072-aws            4.4.0-1072.82                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1074-aws            4.4.0-1074.84                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1075-aws            4.4.0-1075.85                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1077-aws            4.4.0-1077.87                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1079-aws            4.4.0-1079.89                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1081-aws            4.4.0-1081.91                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1083-aws            4.4.0-1083.93                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1084-aws            4.4.0-1084.94                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1085-aws            4.4.0-1085.96                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# rc  linux-image-4.4.0-1087-aws            4.4.0-1087.98                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# ii  linux-image-4.4.0-1088-aws            4.4.0-1088.99                                            amd64        Linux kernel image for version 4.4.0 on 64 bit x86 SMP
# ii  linux-image-aws                       4.15.0.1044.43                                           amd64        Linux kernel image for Amazon Web Services (AWS) systems.
# root@web-scav-01:~# dpkg --list | grep linux-headers
# ii  linux-headers-4.15.0-1044-aws         4.15.0-1044.46                                           amd64        Linux kernel headers for version 4.15.0 on 64 bit x86 SMP
# ii  linux-headers-4.4.0-1047-aws          4.4.0-1047.56                                            amd64        Linux kernel headers for version 4.4.0 on 64 bit x86 SMP
# ii  linux-headers-4.4.0-1088-aws          4.4.0-1088.99                                            amd64        Linux kernel headers for version 4.4.0 on 64 bit x86 SMP
# ii  linux-headers-aws                     4.15.0.1044.43                                           amd64        Linux kernel headers for Amazon Web Services (AWS) systems.

sudo apt-get purge linux-image-4.4.0-1047-aws
sudo apt-get purge linux-image-4.4.0-10{47,50,52,54,55,57,60,61,62,65,66,69,70,72,74,75,77,79,81,83,84,85,87,88}-aws
sudo apt-get purge linux-headers-4.4.0-10{47,88}-aws

If GRUB configuration is not properly updated for whatever reason after old kernels are removed, you can try to update GRUB configuration manually with update-grub2 command.
sudo update-grub2

Another, more user-friendly, way to remove old kernels is via a command-line tool called purge-old-kernels. This tool is a part of bikeshed package, which is a random collection of useful tools.
# sudo apt-get install bikeshed
# After this operation, 112 MB of additional disk space will be used.

https://mintguide.org/system/622-purge-old-kernels-safe-way-to-remove-old-kernels.html
https://www.ostechnix.com/safest-way-remove-old-kernels-ubuntu/
http://blog.dustinkirkland.com/2016/06/purge-old-kernels.html
http://ask.xmodulo.com/remove-kernel-images-ubuntu.html
sudo apt-get install byobu
sudo purge-old-kernels --keep 3 -qy
# E: Command line option --keep is not understood in combination with the other options
==> THIS IS A FAKE!!!
cat /usr/bin/purge-old-kernels
#!/bin/sh
#
#    purge-old-kernels - remove old kernel packages
#    Copyright (C) 2012 Dustin Kirkland <kirkland@ubuntu.com>
#
#    Authors: Dustin Kirkland <kirkland@ubuntu.com>
#             Kees Cook <kees@ubuntu.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, version 3 of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# apt autoremove supposedly works correctly now.
#
# Thus, we're deprecating the functionality previously found
# in purge-old-kernels.
#
# If you still have old kernels lying around after this, please
# file a bug against apt: https://bugs.launchpad.net/ubuntu/+source/apt/+filebug

# sudo apt-get $@ autoremove


https://github.com/erichs/bootnukem
cd /usr/local/src/
git clone https://github.com/erichs/bootnukem.git
cd bootnukem
sudo ./install.sh

sudo bootnukem
