# YUM EXAMPLES:
#--------------
# Could not retrieve mirrorlist http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-16&arch=x86_64 error was 14: HTTP Error 404 - Not Found: http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-16&arch=x86_64 Error: Cannot find a valid baseurl for repo: rpmfusion-free
# ==> :
yum clean all
yum makecache
yum distribution-synchronization
rpm --rebuilddb 
yum update
yum check

# ==> under /etc/yum.repos.d/* replace:
http://download.fedoraproject.org/pub/fedora/linux/releases/
ftp://ftp.ciril.fr/pub/linux/fedora/linux/releases/
# by:
http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/


#list activated repositories
yum repolist all

#list where files would be installed
repoquery --list libnotify

#list where files ARE installed
repoquery --list --installed libnotify.i686
repoquery --list --installed libnotify.x86_64
repoquery --list --installed libnotify-devel.i686
repoquery --list --installed java-1.6.0-openjdk.x86_64


# SEARCH !
yum search pcap
yum search --showduplicates pcap

# Loaded plugins: langpacks, presto, refresh-packagekit
# ============================================================================== N/S Matched: pcap ==============================================================================
# jpcap-javadoc.x86_64 : Javadocs for jpcap
# libpcap-devel.i686 : Libraries and header files for the libpcap library
# libpcap-devel.x86_64 : Libraries and header files for the libpcap library


#list installed package names
repoquery list --installed file/package

#list ALL packages available
yum list --showduplicates ffmpegthumbnailer
	# ffmpegthumbnailer.i686		2.0.7-1.fc16	rpmfusion-free
	# ffmpegthumbnailer.x86_64	2.0.7-1.fc16	rpmfusion-free

yumdownloader ffmpegthumbnailer.i686

yum whatprovides /lib/libgcc_s.so.1
yum whatprovides sys/stropts.h

# find available packages
yum search --showduplicates ffmpegthumbnailer
	# ffmpegthumbnailer-devel.i686 : Headers and libraries for building apps that use ffmpegthumbnailer
	# ffmpegthumbnailer-devel.x86_64 : Headers and libraries for building apps that use ffmpegthumbnailer
	# ffmpegthumbnailer.i686 : Lightweight video thumbnailer that can be used by file managers
	# ffmpegthumbnailer.x86_64 : Lightweight video thumbnailer that can be used by file managers

# Find out dependencies of a uninstalled package
yum deplist ffmpegthumbnailer.i686
	# Loaded plugins: langpacks, presto, refresh-packagekit
	# package: ffmpegthumbnailer.i686 2.0.7-1.fc16
	  # dependency: /sbin/ldconfig
	   # provider: glibc.x86_64 2.14.90-24.fc16.9
	   # provider: glibc.i686 2.14.90-24.fc16.9
	  # dependency: libavcodec.so.53
	   # provider: ffmpeg-libs.i686 0.8.12-1.fc16
#

# reinstall ALL dependencies of a package:
# ... with full packages names:
yum reinstall -y $(repoquery --requires --recursive --resolve xorg-x11-apps)
# ... with short names:
yum reinstall -y $(repoquery --requires --recursive --resolve xorg-x11-apps|cut -f1 -d\-)

# JAVA: http://www.if-not-true-then-false.com/2010/install-sun-oracle-java-jdk-jre-7-on-fedora-centos-red-hat-rhel/
alternatives --config java
# There are 5 programs which provide 'java'.
 
  # Selection    Command
# -----------------------------------------------
# *  1           /usr/java/jdk1.6.0_24/jre/bin/java
   # 2           /usr/lib/jvm/jre-1.5.0-gcj/bin/java
 # + 3           /usr/java/jdk1.6.0_26/jre/bin/java
   # 4           /usr/lib/jvm/jre-1.6.0-openjdk/bin/java
   # 5           /usr/java/jdk1.7.0_45/jre/bin/java
 
# Enter to keep the current selection[+], or type selection number: 5

# ERRORS ------------------------------------
yum install ffmpeg-libs-0.8.12-1.fc16.x86_64
# Downloading Packages:
# warning: rpmts_HdrFromFdno: Header V3 RSA/SHA256 Signature, key ID adf25d9c: NOKEY
# Retrieving key from file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-16-x86_64
# GPG key retrieval failed: [Errno 14] Could not open/read file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmfusion-free-fedora-16-x86_64

# SOLUTION: -----------------------------------
yum install --nogpgcheck ffmpeg-libs-0.8.12-1.fc16.x86_64
# ---------------------------------------------


