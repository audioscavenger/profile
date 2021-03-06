# RPM EXAMPLES:
#--------------
# extract content:
rpm2cpio openldap-devel-2.4.23-0.3.aix5.1.ppc.rpm | cpio -idmv

# Find out dependencies of a NOT INSTALLED RPM file:
rpm -qRp m4-1.4.17-1.aix5.1.ppc.rpm
rpm -qp m4-1.4.17-1.aix5.1.ppc.rpm --requires
# /sbin/install-info
# info
# libsigsegv >= 2.6
# /bin/sh
# libc.a(shr.o)
# libsigsegv.a(libsigsegv.so.0)

# Find out dependencies of a RPM link:
# rpm -qRp http://download1.rpmfusion.org/free/fedora/releases/17/Everything/x86_64/os/ffmpegthumbnailer-2.0.7-4.fc17.x86_64.rpm
# /sbin/ldconfig
# /sbin/ldconfig
# libavcodec.so.53()(64bit)
# libavcodec.so.53(LIBAVCODEC_53)(64bit)
# libavformat.so.53()(64bit)
# libavformat.so.53(LIBAVFORMAT_53)(64bit)
# libavutil.so.51()(64bit)
# libavutil.so.51(LIBAVUTIL_51)(64bit)
# libc.so.6()(64bit)
# libc.so.6(GLIBC_2.11)(64bit)
# libc.so.6(GLIBC_2.14)(64bit)
# libc.so.6(GLIBC_2.2.5)(64bit)
# libdl.so.2()(64bit)
# libdl.so.2(GLIBC_2.2.5)(64bit)
# libffmpegthumbnailer.so.4()(64bit)
# libgcc_s.so.1()(64bit)
# libgcc_s.so.1(GCC_3.0)(64bit)
# libjpeg.so.62()(64bit)
# libjpeg.so.62(LIBJPEG_6.2)(64bit)

#install a remote rpm:
rpm -ivh --force http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-linux-x64.rpm
rpm -ivh --force http://download.oracle.com/otn/java/jdk/6u45-b06/jdk-6u45-linux-x64-rpm.bin

# show installed RPM:
rpm -qa |grep ssl
# openssl-devel-0.9.7l-2
# openssl-doc-0.9.7l-2
# openssl-0.9.7l-2

# print installed files from RPM:
rpm --verify openssl-devel-0.9.7l-2
# .....UG.   /opt/freeware/64
# .....UG.   /opt/freeware/64/lib

root[@]dev-lnx-lib001:/root # rpm -ql libxml2-2.7.6-0.25.1
/usr/bin/xmlcatalog
/usr/bin/xmllint
/usr/lib/libxml2.so.2
/usr/lib/libxml2.so.2.7.6
/usr/share/doc/packages/libxml2
/usr/share/doc/packages/libxml2/AUTHORS
/usr/share/doc/packages/libxml2/COPYING
/usr/share/doc/packages/libxml2/Copyright
/usr/share/doc/packages/libxml2/NEWS
/usr/share/doc/packages/libxml2/README
/usr/share/doc/packages/libxml2/TODO
/usr/share/doc/packages/libxml2/TODO_SCHEMAS
/usr/share/man/man1/xmlcatalog.1.gz
/usr/share/man/man1/xmllint.1.gz


# root[@]tpl-unx-aix71s:/usr2/produits/apache22/bin # ldd httpd
# httpd needs:
         # /opt/freeware/lib/libaprutil-1.so
         # /opt/freeware/lib/libdb-4.7.so
         # /usr/lib/libC.a(shr.o)
         # /opt/freeware/lib/libapr-1.so
         # /usr/lib/libpthread.a(shr_xpg5.o)
         # /usr/lib/libc.a(shr.o)
         # /usr/lib/librtl.a(shr.o)
         # /opt/freeware/lib/libexpat.a(libexpat.so.1)
         # /opt/freeware/lib/libiconv.a(libiconv.so.2)
         # /usr/lib/libC.a(shrcore.o)
         # /unix
         # /usr/lib/libpthreads.a(shr_comm.o)
         # /usr/lib/libcrypt.a(shr.o)
         # /usr/lib/libC.a(ansicore_32.o)
rpm -q --whatprovides /opt/freeware/lib/libaprutil-1.so
# apr-util-1.5.2-1

# find out dependencies of a installed package: <<==
rpm -q --requires apr-util-1.5.2-1
rpm -qR apr-util-1.5.2-1
rpm -qR apr-util
apr >= 1.4.5
# expat >= 2.0.0
# libiconv >= 1.14-2
# libapr-1.so
# libc.a(shr.o)
# libexpat.a(libexpat.so.1)
# libiconv.a(libiconv.so.2)

# ==>> find out installed packages needing THIS package:
rpm -q --whatrequires expat | sort | uniq
# apr-util-1.5.2-1
# expat-devel-2.1.0-1
# fontconfig-2.10.2-1
# ganglia-lib-3.6.0-2
# ganglia-p6-gmond-3.6.0-2
