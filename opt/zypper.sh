# ZYPPER EXAMPLES:
#-----------------
zypper --gpg-auto-import-keys addrepo -cf cd:///?devices=/dev/sr0 DVD1-11.2
zypper --gpg-auto-import-keys addrepo -cf cd:///?devices=/dev/sr0 DVD2-11.2
zypper --gpg-auto-import-keys addrepo -cf http://demeter.uni-regensburg.de/SLE11SP2-SDK-x86/DVD1/ SDK-DVD1-11.2
zypper --gpg-auto-import-keys addrepo -cf http://demeter.uni-regensburg.de/SLE11SP2-SDK-x86/DVD2/ SDK-DVD2-11.2

zypper --gpg-auto-import-keys addrepo -cf http://download.opensuse.org/distribution/11.2/repo/oss/ oss-11.2
zypper --gpg-auto-import-keys addrepo -cf http://download.opensuse.org/distribution/11.2/repo/non-oss/ non-oss-11.2
zypper --gpg-auto-import-keys addrepo -cf http://download.opensuse.org/update/11.2/ upd-oss-11.2

zypper --gpg-auto-import-keys addrepo -cf http://ftp5.gwdg.de/pub/opensuse/repositories/Apache/SLE_11_SP2/ apache-SLE11.2
zypper --gpg-auto-import-keys addrepo -cf http://ftp5.gwdg.de/pub/opensuse/repositories/Apache:/Modules/Apache_SLE_11_SP2/ apache-mod-SLE11.2

zypper --gpg-auto-import-keys addrepo -cf http://download.opensuse.org/repositories/SUSE:/SLE-11:/SP2:/Update/standard/ upd-SLE11.2
zypper --gpg-auto-import-keys addrepo -cf http://download.opensuse.org/repositories/XML/SLE_11/ xml-SLE11.2

# http://mirrors.vbi.vt.edu/mirrors/linux/opensuse/discontinued/distribution/11.2/repo/oss/suse/x86_64/

#list activated repositories
zypper lr -u
#   | Alias          | Name           | Enabled | Refresh | URI
# --+----------------+----------------+---------+---------+---------------------------------------------------------------------------------
# 1 | SUSE-Linux-Enterprise-Server-11-SP2 11.2.2-1.234 | SUSE-Linux-Enterprise-Server-11-SP2 11.2.2-1.234 | Yes     | No      | cd:///?devices=/dev/sr0
# 1 | apache         | apache         | Yes     | Yes     | http://ftp5.gwdg.de/pub/opensuse/repositories/Apache/SLE_11_SP2/
# 2 | apache-modules | apache-modules | Yes     | Yes     | http://ftp5.gwdg.de/pub/opensuse/repositories/Apache:/Modules/Apache_SLE_11_SP2/
# 3 | oss            | oss            | Yes     | Yes     | http://download.opensuse.org/distribution/11.2/repo/oss/
# 4 | updates        | updates        | Yes     | Yes     | http://download.opensuse.org/update/11.2/

zypper refresh -s
# All services have been refreshed.
# Repository 'apache' is up to date.
# Repository 'apache-modules' is up to date.
# Repository 'oss' is up to date.
# Repository 'upd_sle' is up to date.
# Repository 'updates' is up to date.
# All repositories have been refreshed.

#list (non) AND installed package names
zypper search -s libxml2
zypper search -s apache2
# Loading repository data...
# Warning: Repository 'updates' appears to outdated. Consider using a different mirror or server.
# Reading installed packages...

# S | Name                              | Type       | Version                      | Arch   | Repository
# --+-----------------------------------+------------+------------------------------+--------+-------------------------------------------------
  # | CASA_auth_token_apache2_2_support | package    | 1.7.1587-3.3                 | i586   | oss
  # | apache2                           | package    | 2.4.3-3.1                    | i586   | apache
  # | apache2                           | package    | 2.2.13-2.4.1                 | i586   | updates
  # | apache2                           | package    | 2.2.13-2.3.1                 | i586   | oss

# info on installed package:
zypper info openssl

# list all installable+installed packages:
zypper packages |grep ssl
  # | suse       | docbook-dsssl-stylesheets                     | 1.79-19.6                     | noarch
# v | suse       | libopenssl-devel                              | 0.9.8h-30.11                  | i586
# v | suse       | libopenssl0_9_8                               | 0.9.8j-0.26.1                 | i586
# v | suse       | openssl                                       | 0.9.8j-0.26.1                 | i586
# i | suse       | openssl-certs                                 | 0.9.8h-27.3.1                 | noarch
  # | suse       | openssl-doc                                   | 0.9.8j-0.26.1                 | i586
  # | suse       | openssl-ibmca                                 | 1.0.0-141.13.1                | i586
  # | suse       | openssl-ibmpkcs11                             | 1.0.0-0.7.47                  | i586
  # | suse       | openssl_tpm_engine                            | 0.4.1-2.26                    | i586
# v | suse       | perl-ldap-ssl                                 | 0.37-1.19.3                   | i586
# v | suse       | perl-ldap-ssl                                 | 0.37-1.17                     | i586
  # | suse       | php5-openssl                                  | 5.4.18-178.12                 | i586
  # | suse       | php5-openssl                                  | 5.4.18-178.1                  | i586
  # | suse       | php5-openssl                                  | 5.2.14-0.7.24.1               | i586
  # | suse       | php5-openssl                                  | 5.2.6-50.17                   | i586
  # | suse       | php53-openssl                                 | 5.3.8-0.19.6                  | i586
  # | suse       | python-openssl                                | 0.7.0-1.17.2                  | i586


# There are some running programs that use files deleted by recent upgrade. You may wish to restart some of them. Run 'zypper ps' to list these programs.
zypper ps
# PID   | PPID  | UID  | Login  | Command | Service | Files
# ------+-------+------+--------+---------+---------+----------------------------------------------------
# 2110  | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 2370  | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 2374  | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 2375  | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 2377  | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 2409  | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 2567  | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 5591  | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 5595  | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 13327 | 1     | 0    | root   | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1
# 16252 | 13327 | 1066 | apache | httpd   |         | /usr2/produits/apache2222/bin/httpd (deleted)
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libexpat.so.0.5.0
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libapr-1.so.0.4.5
      # |       |      |        |         |         | /usr2/produits/apache2222/lib/libaprutil-1.so.0.4.1

# Manage Packages
# Once you have one or more repositories configured, you may install or remove packages.

# To INSTALL one or more packages from repositories
# Syntax: zypper {install|in} :repositoy name}:{name of packages}

zypper install php apache mysql
zypper install OSS:postgresql

# ----------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------
# !!! WARNING with packages versions !!! the highest will always be selected:
root[@]dev-lnx-lib001:/etc/zypp/repos.d # zypper install apache2-mod_php5
# Loading repository data...
# Reading installed packages...
# Resolving package dependencies...

# Problem: nothing provides libc.so.6(GLIBC_2.15) needed by apache2-mod_php5-5.4.18-178.12.i586
 # Solution 1: do not install apache2-mod_php5-5.4.18-178.12.i586
 # Solution 2: break apache2-mod_php5 by ignoring some of its dependencies

# Choose from above solutions by number or cancel [1/2/c] (c):

# =============> solution is to take an older version that fit the system:
root[@]dev-lnx-lib001:/etc/zypp/repos.d # zypper packages |grep php
  # | suse       | apache2-mod_php5                              | 5.4.18-178.12                 | i586
  # | suse       | apache2-mod_php5                              | 5.4.18-178.1                  | i586
  # | suse       | apache2-mod_php5                              | 5.2.14-0.7.24.1               | i586
  # | suse       | apache2-mod_php5                              | 5.2.6-50.17                   | i586
  # | suse       | apache2-mod_php53                             | 5.3.8-0.19.6                  | i586

root[@]dev-lnx-lib001:/etc/zypp/repos.d # zypper install apache2-mod_php5-5.4.18-178.1
# Loading repository data...
# Reading installed packages...
# Resolving package dependencies...

# The following NEW packages are going to be installed:
  # apache2-mod_php5 php5 php5-ctype php5-dom php5-iconv php5-json php5-pdo php5-sqlite php5-tokenizer php5-xmlreader php5-xmlwriter

# The following recommended packages were automatically selected:
  # php5-ctype php5-dom php5-iconv php5-json php5-sqlite php5-tokenizer php5-xmlreader php5-xmlwriter

# The following packages are not supported by their vendor:
  # apache2-mod_php5 php5 php5-ctype php5-dom php5-iconv php5-json php5-pdo php5-sqlite php5-tokenizer php5-xmlreader php5-xmlwriter

# 11 new packages to install.
# Overall download size: 3.2 MiB. After the operation, additional 12.3 MiB will be used.
# Continue? [y/n/?] (y):
# ----------------------------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------




	# To REMOVE one or more packages from repositories
	# Syntax: zypper {remove|rm} {name of packages}

zypper remove php apache

# Command Reference:
# zypper in{stall} {package} – Install or Update packages on OpenSUSE
# zypper in{stall} {package-version} – Use this to install a specific version of a package.
# zypper in{stall} {package} {-package} {+package} – you can install and remove multiple packages at the same time using the + – switches.
# zypper in{stall} --force {package} – This will force the installation or re-installation of a package.
# zypper in{stall} {rpm-file} – You can use this to install rpm files.
# zypper {rm|remove} {package} – Use this to remove packages from your system.
# zypper {rm|remove} {package-version} – Use this to remove older versions of the specified package.
# zypper {source-install|si} {package} – Install source packages.
# zypper up{date} – Update all of the packages on your system.
# zypper up{date} {package} – Update an individual package.
# zypper dup – Update all packages, and upgrade your distribution if a newer version is available.
# zypper help – Display the Zypper help files.
# zypper info package – Get info about the specified package.


# force reinstall :
zypper install --force DVD1-11.2:libxml2
zypper install --force DVD1-11.2:liblua5_1

zypper --root ${ROOT2} install --force oss-11.2:libxml2

zypper install ftp://ftp.isu.edu.tw/pub/Linux/OpenSuSE/distribution/10.3/repo/oss/suse/i586/rsync-2.6.9-54.i586.rpm
zypper install http://ftp5.gwdg.de/pub/opensuse/discontinued/distribution/10.3/repo/oss/suse/i586/rsync-2.6.9-54.i586.rpm
zypper install http://hisyres.lpl.arizona.edu/mirrors/SuSE-10.3/repo/debug/suse/i586/rsync-debuginfo-2.6.9-54.i586.rpm

############################################
# CHROOT:
# add chrooted repositories :
ROOT2=/usr2/produits/SLES11.2
mkdir -p ${ROOT2}/dev
cp -a /dev/zero ${ROOT2}/dev/

zypper --root ${ROOT2} --gpg-auto-import-keys addrepo -cf cd:///?devices=/dev/sr0 DVD1-11.2
zypper --root ${ROOT2} --gpg-auto-import-keys addrepo -cf http://download.opensuse.org/distribution/11.2/repo/oss/ oss-11.2
zypper --root ${ROOT2} --gpg-auto-import-keys addrepo -cf http://download.opensuse.org/distribution/11.2/repo/non-oss/ non-oss-11.2
zypper --root ${ROOT2} --gpg-auto-import-keys addrepo -cf http://download.opensuse.org/update/11.2/ upd-oss-11.2
zypper --root ${ROOT2} --gpg-auto-import-keys addrepo -cf http://ftp5.gwdg.de/pub/opensuse/repositories/Apache/SLE_11_SP2/ apache-SLE11.2
zypper --root ${ROOT2} --gpg-auto-import-keys addrepo -cf http://ftp5.gwdg.de/pub/opensuse/repositories/Apache:/Modules/Apache_SLE_11_SP2/ apache-mod-SLE11.2
zypper --gpg-auto-import-keys addrepo -cf http://download.opensuse.org/repositories/SUSE:/SLE-11:/SP2:/Update/standard/ upd-SLE11.2
zypper --root ${ROOT2} --gpg-auto-import-keys refresh

zypper --root ${ROOT2} install --no-recommends apache2 apache2-worker apache2-prefork apache2-icons-oxygen apache2-itk apache2-mod_auth_token apache2-mod_authnz_external apache2-mod_bmx apache2-mod_chroot apache2-mod_evasive apache2-mod_jk apache2-mod_limitipconn apache2-mod_memcache apache2-mod_proxy_html apache2-mod_security2 apache2-utils libapr1 libapr-util1 pwauth

############################################
# securize SLES SP3:
root[@]dev-lnx-lib001:/usr2/produits # zypper lr -u
#  | Alias                                     | Name                        | Enabled | Refresh | URI                                                                         
---+-------------------------------------------+-----------------------------+---------+---------+---------------------------------------------------------------------------------------------------
 1 | nu_novell_com:SLE11-SP1-Debuginfo-Pool    | SLE11-SP1-Debuginfo-Pool    | No      | Yes     | https://nu.novell.com/repo/$RCE/SLE11-SP1-Debuginfo-Pool/sle-11-i586?credentials=NCCcredentials
 2 | nu_novell_com:SLE11-SP1-Debuginfo-Updates | SLE11-SP1-Debuginfo-Updates | No      | Yes     | https://nu.novell.com/repo/$RCE/SLE11-SP1-Debuginfo-Updates/sle-11-i586?credentials=NCCcredentials
 3 | nu_novell_com:SLE11-SP2-Debuginfo-Core    | SLE11-SP2-Debuginfo-Core    | No      | Yes     | https://nu.novell.com/repo/$RCE/SLE11-SP2-Debuginfo-Core/sle-11-i586?credentials=NCCcredentials
 4 | nu_novell_com:SLE11-SP2-Debuginfo-Updates | SLE11-SP2-Debuginfo-Updates | No      | Yes     | https://nu.novell.com/repo/$RCE/SLE11-SP2-Debuginfo-Updates/sle-11-i586?credentials=NCCcredentials
 5 | nu_novell_com:SLE11-SP3-Debuginfo-Pool    | SLE11-SP3-Debuginfo-Pool    | No      | Yes     | https://nu.novell.com/repo/$RCE/SLE11-SP3-Debuginfo-Pool/sle-11-i586?credentials=NCCcredentials
 6 | nu_novell_com:SLE11-SP3-Debuginfo-Updates | SLE11-SP3-Debuginfo-Updates | No      | Yes     | https://nu.novell.com/repo/$RCE/SLE11-SP3-Debuginfo-Updates/sle-11-i586?credentials=NCCcredentials
 7 | nu_novell_com:SLE11-Security-Module       | SLE11-Security-Module       | No      | Yes     | https://nu.novell.com/repo/$RCE/SLE11-Security-Module/sle-11-i586?credentials=NCCcredentials
 8 | nu_novell_com:SLE11-WebYaST-SP2-Pool      | SLE11-WebYaST-SP2-Pool      | No      | Yes     | https://nu.novell.com/repo/$RCE/SLE11-WebYaST-SP2-Pool/sle-11-i586?credentials=NCCcredentials
 9 | nu_novell_com:SLE11-WebYaST-SP2-Updates   | SLE11-WebYaST-SP2-Updates   | No      | Yes     | https://nu.novell.com/repo/$RCE/SLE11-WebYaST-SP2-Updates/sle-11-i586?credentials=NCCcredentials
10 | nu_novell_com:SLES11-Extras               | SLES11-Extras               | No      | Yes     | https://nu.novell.com/repo/$RCE/SLES11-Extras/sle-11-i586?credentials=NCCcredentials
11 | nu_novell_com:SLES11-SP1-Pool             | SLES11-SP1-Pool             | No      | Yes     | https://nu.novell.com/repo/$RCE/SLES11-SP1-Pool/sle-11-i586?credentials=NCCcredentials
12 | nu_novell_com:SLES11-SP1-Updates          | SLES11-SP1-Updates          | No      | Yes     | https://nu.novell.com/repo/$RCE/SLES11-SP1-Updates/sle-11-i586?credentials=NCCcredentials
13 | nu_novell_com:SLES11-SP2-Core             | SLES11-SP2-Core             | No      | Yes     | https://nu.novell.com/repo/$RCE/SLES11-SP2-Core/sle-11-i586?credentials=NCCcredentials
14 | nu_novell_com:SLES11-SP2-Extension-Store  | SLES11-SP2-Extension-Store  | No      | Yes     | https://nu.novell.com/repo/$RCE/SLES11-SP2-Extension-Store/sle-11-i586?credentials=NCCcredentials
15 | nu_novell_com:SLES11-SP2-Updates          | SLES11-SP2-Updates          | No      | Yes     | https://nu.novell.com/repo/$RCE/SLES11-SP2-Updates/sle-11-i586?credentials=NCCcredentials
16 | nu_novell_com:SLES11-SP3-Extension-Store  | SLES11-SP3-Extension-Store  | No      | Yes     | https://nu.novell.com/repo/$RCE/SLES11-SP3-Extension-Store/sle-11-i586?credentials=NCCcredentials
17 | nu_novell_com:SLES11-SP3-Pool             | SLES11-SP3-Pool             | Yes     | Yes     | https://nu.novell.com/repo/$RCE/SLES11-SP3-Pool/sle-11-i586?credentials=NCCcredentials
18 | nu_novell_com:SLES11-SP3-Updates          | SLES11-SP3-Updates          | Yes     | Yes     | https://nu.novell.com/repo/$RCE/SLES11-SP3-Updates/sle-11-i586?credentials=NCCcredentials


