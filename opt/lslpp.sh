root[@]tpl-unx-aix71s:/root # lslpp -l openssl*
  Fileset                      Level  State      Description
  ----------------------------------------------------------------------------
Path: /usr/lib/objrepos
  openssl.base             1.0.1.500  COMMITTED  Open Secure Socket Layer

Path: /etc/objrepos
  openssl.base             1.0.1.500  COMMITTED  Open Secure Socket Layer
root[@]tpl-unx-aix71s:/root # lslpp -f openssl.base
  Fileset               File
  ----------------------------------------------------------------------------
Path: /usr/lib/objrepos
  openssl.base 1.0.1.500
                        /usr/include/openssl/modes.h
                        /usr/include/openssl/hmac.h
                        /usr/include/openssl/ripemd.h
                        /usr/include/openssl/md4.h
                        /usr/include/openssl/bn.h
                        /usr/include/openssl/asn1.h
                        /usr/include/openssl/pqueue.h
                        /usr/include/openssl/md2.h
                        /usr/include/openssl/ssl2.h
                        /usr/include/openssl/ocsp.h
                        /usr/bin/openssl64
                        /usr/include/openssl/pkcs12.h
                        /usr/include/openssl/seed.h
                        /usr/include/openssl/sha.h
                        /usr/openssl/LICENSE
                        /usr/include/openssl/dsa.h
                        /usr/include/openssl/camellia.h
                        /usr/include/openssl/pq_compat.h
                        /usr/include/openssl/dh.h
                        /usr/include/openssl/blowfish.h
                        /usr/include/openssl/lhash.h
                        /usr/include/openssl/srp.h
                        /usr/include/openssl/objects.h
                        /usr/lib/libcrypto_compat.a
                        /usr/include/openssl/obj_mac.h
                        /usr/bin/openssl
                        /usr/include/openssl/tls1.h
                        /usr/include/openssl/ui_compat.h
                        /usr/include/openssl/srtp.h
                        /usr/include/openssl/rand.h
                        /usr/include/openssl/ecdh.h
                        /usr/include/openssl/ui.h
                        /usr/include/openssl/asn1t.h
                        /usr/include/openssl/ec.h
                        /usr/include/openssl/des_old.h
                        /usr/include/openssl/x509_vfy.h
                        /usr/include/openssl/des.h
                        /usr/lib/libssl.a
                        /usr/include/openssl/opensslv.h
                        /usr/include/openssl/err.h
                        /usr/include/openssl/md5.h
                        /usr/include/openssl/whrlpool.h
                        /usr/include/openssl/store.h
                        /usr/include/openssl/x509v3.h
                        /usr/include/openssl/tmdiff.h
                        /usr/include/openssl/ossl_typ.h
                        /usr/include/openssl/ssl3.h
                        /usr/include/openssl/kssl.h
                        /usr/include/openssl/ebcdic.h
                        /usr/include/openssl/ts.h
                        /usr/include/openssl/conf.h
                        /usr/include/openssl/evp.h
                        /usr/include/openssl/asn1_mac.h
                        /usr/include/openssl/buffer.h
                        /usr/include/openssl/pkcs7.h
                        /usr/include/openssl/dtls1.h
                        /usr/lib/libssl_compat.a
                        /usr/include/openssl/mdc2.h
                        /usr/include/openssl/rc4.h
                        /usr/include/openssl/cms.h
                        /usr/include/openssl/conf_api.h
                        /usr/include/openssl/safestack.h
                        /usr/include/openssl/pem.h
                        /usr/include/openssl/dso.h
                        /usr/include/openssl/pem2.h
                        /usr/include/openssl/comp.h
                        /usr/include/openssl/rc2.h
                        /usr/lib/libcrypto.a
                        /usr/openssl/README
                        /usr/include/openssl/txt_db.h
                        /usr/include/openssl/x509.h
                        /usr/include/openssl/ecdsa.h
                        /usr/include/openssl/krb5_asn.h
                        /usr/include/openssl/cmac.h
                        /usr/include/openssl/ssl23.h
                        /usr/include/openssl/opensslconf.h
                        /usr/include/openssl/stack.h
                        /usr/include/openssl/engine.h
                        /usr/include/openssl/cast.h
                        /usr/include/openssl/ssl.h
                        /usr/include/openssl/aes.h
                        /usr/include/openssl/rsa.h
                        /usr/include/openssl/e_os2.h
                        /usr/include/openssl/bio.h
                        /usr/include/openssl/crypto.h
                        /usr/bin/c_rehash
                        /usr/include/openssl/symhacks.h

Path: /etc/objrepos
  openssl.base 1.0.1.500
                        /var/ssl/misc/CA.pl
                        /var/ssl/misc/CA.sh
                        /var/ssl/misc/c_name
                        /var/ssl/misc/c_hash
                        /var/ssl/misc/tsget
                        /var/ssl/openssl.cnf
                        /var/ssl/misc/c_info
                        /var/ssl/misc/c_issuer
root[@]tpl-unx-aix71s:/root # lslpp -l idsldap*
  Fileset                      Level  State      Description
  ----------------------------------------------------------------------------
Path: /usr/lib/objrepos
  idsldap.clt32bit62.rte    6.2.0.32  COMMITTED  Directory Server - 32 bit
                                                 Client
  idsldap.clt64bit62.rte    6.2.0.32  COMMITTED  Directory Server - 64 bit
                                                 Client
  idsldap.cltbase62.adt     6.2.0.32  COMMITTED  Directory Server - Base Client
  idsldap.cltbase62.rte     6.2.0.32  COMMITTED  Directory Server - Base Client

Path: /etc/objrepos
  idsldap.clt32bit62.rte    6.2.0.32  COMMITTED  Directory Server - 32 bit
                                                 Client
  idsldap.clt64bit62.rte    6.2.0.32  COMMITTED  Directory Server - 64 bit
                                                 Client
  idsldap.cltbase62.rte     6.2.0.32  COMMITTED  Directory Server - Base Client
root[@]tpl-unx-aix71s:/root # lslpp -f idsldap.clt32bit62.rte
  Fileset               File
  ----------------------------------------------------------------------------
Path: /usr/lib/objrepos
  idsldap.clt32bit62.rte 6.2.0.32
                        /opt/IBM/ldap/V6.2/lib/libibmldapn.a
                        /opt/IBM/ldap/V6.2/etc
                        /opt/IBM/ldap/V6.2/lib/libidsmd5.a
                        /opt/IBM/ldap/V6.2/lib/idsldap_plugin_sasl_digest-md5.a
                        /opt/IBM/ldap/V6.2/bin/32/ldaptrace
                        /opt/IBM/ldap/V6.2/lib/libidsmsg.a
                        /opt/IBM/ldap/V6.2/lib/libidsldapiconv.a
                        /opt/IBM/ldap/V6.2/lib
                        /opt/IBM/ldap/V6.2/lib/idsldap_plugin_ibm_gsskrb.a
                        /opt/IBM/ldap/V6.2/bin/32/ldapdelete
                        /opt/IBM/ldap/V6.2/bin/32/ibmdirctl
                        /opt/IBM/ldap/V6.2/bin/32/ldapmodify
                        /opt/IBM/ldap/V6.2/bin/32/ldapexop
                        /opt/IBM/ldap/V6.2/lib/libibmldapstaticn.a
                        /opt/IBM/ldap/V6.2/lib/libibmldapdbg.a
                        /opt/IBM/ldap/V6.2/lib/libidsldap.a -> /opt/IBM/ldap/V6.2/lib/libibmldap.a
                        /opt/IBM/ldap/V6.2/bin/32/ldapcompare
                        /opt/IBM/ldap/V6.2/bin/32/idsversion
                        /opt/IBM/ldap/V6.2/bin/32/ldapmodrdn
                        /opt/IBM/ldap/V6.2/bin/32/ldapchangepwd
                        /opt/IBM/ldap/V6.2/bin/32/tbindmsg
                        /opt/IBM/ldap/V6.2/bin/32/ldapadd -> /opt/IBM/ldap/V6.2/bin/32/ldapmodify
                        /opt/IBM/ldap/V6.2/lib/libidsldifstatic.a
                        /opt/IBM/ldap/V6.2/bin/32
                        /opt/IBM/ldap/V6.2/lib/libidsldapstatic.a -> /opt/IBM/ldap/V6.2/lib/libibmldapstatic.a
                        /opt/IBM/ldap/V6.2/lib/libidsstr.a
                        /opt/IBM/ldap/V6.2/lib/libidsmsgstatic.a
                        /opt/IBM/ldap/V6.2/bin/32/ldapsearch

Path: /etc/objrepos
  idsldap.clt32bit62.rte 6.2.0.32
                        NONE
root[@]tpl-unx-aix71s:/root # lslpp -f idsldap.cltbase62.rte
  Fileset               File
  ----------------------------------------------------------------------------
Path: /usr/lib/objrepos
  idsldap.cltbase62.rte 6.2.0.32
                        /opt/IBM/ldap/V6.2/codeset/TIS6202533
                        /opt/IBM/ldap/V6.2/bin/ibmdirctl
                        /opt/IBM/ldap/V6.2/codeset/500
                        /opt/IBM/ldap/V6.2/codeset/775
                        /opt/IBM/ldap/V6.2/bin/idsldapdelete
                        /opt/IBM/ldap/V6.2/codeset/HP15CN
                        /opt/IBM/ldap/V6.2/codeset
                        /opt/IBM/ldap/V6.2/etc
                        /opt/IBM/ldap/V6.2/bin/idsldapcompare
                        /opt/IBM/ldap/V6.2/bin/idsldaptrace
                        /opt/IBM/ldap/V6.2/codeset/TIS620
                        /opt/IBM/ldap/V6.2/bin/idsldapadd
                        /opt/IBM/ldap/V6.2/bin/idsldapchangepwd
                        /opt/IBM/ldap/V6.2/codeset/JAJPEUC
                        /opt/IBM/ldap/V6.2/codeset/BIG5
                        /opt/IBM/ldap/V6.2/bin/idsdirctl
                        /opt/IBM/ldap/V6.2/bin/idslink
                        /opt/IBM/ldap/V6.2/bin/ldapexop
                        /opt/IBM/ldap/V6.2/codeset/ANSIX341968
                        /opt/IBM/ldap/V6.2/codeset/KOI8R
                        /opt/IBM/ldap/V6.2/lib
                        /opt/IBM/ldap/V6.2/codeset/ISO88591
                        /opt/IBM/ldap/V6.2/codeset/ISO88592
                        /opt/IBM/ldap/V6.2/codeset/ISO88594
                        /opt/IBM/ldap/V6.2/codeset/ISO88595
                        /opt/IBM/ldap/V6.2/codeset/ISO88596
                        /opt/IBM/ldap/V6.2/codeset/ISO88597
                        /opt/IBM/ldap/V6.2/codeset/ISO88598
                        /opt/IBM/ldap/V6.2/codeset/ISO88599
                        /opt/IBM/ldap/V6.2/include
                        /opt/IBM/ldap/V6.2/bin/ldapmodify
                        /opt/IBM/ldap/V6.2/codeset/CP1251
                        /opt/IBM/ldap/V6.2/codeset/CP1255
                        /opt/IBM/ldap/V6.2/etc/ITDSSRV0602.SYS2
                        /opt/IBM/ldap/V6.2/codeset/5601
                        /opt/IBM/ldap/V6.2/bin/idsldapmodify
                        /opt/IBM/ldap/V6.2/codeset/ANSI1251
                        /opt/IBM/ldap/V6.2/codeset/SJIS
                        /opt/IBM/ldap/V6.2/bin/tbindmsg
                        /opt/IBM/ldap/V6.2/codeset/803
                        /opt/IBM/ldap/V6.2/bin/ldapmodrdn
                        /opt/IBM/ldap/V6.2/codeset/813
                        /opt/IBM/ldap/V6.2/codeset/819
                        /opt/IBM/ldap/V6.2/codeset/838
                        /opt/IBM/ldap/V6.2/codeset/1250
                        /opt/IBM/ldap/V6.2/codeset/1251
                        /opt/IBM/ldap/V6.2/codeset/1252
                        /opt/IBM/ldap/V6.2/codeset/1253
                        /opt/IBM/ldap/V6.2/codeset/1254
                        /opt/IBM/ldap/V6.2/codeset/1255
                        /opt/IBM/ldap/V6.2/codeset/1256
                        /opt/IBM/ldap/V6.2/codeset/1257
                        /opt/IBM/ldap/V6.2/codeset/1258
                        /opt/IBM/ldap/V6.2/codeset/850
                        /opt/IBM/ldap/V6.2/codeset/851
                        /opt/IBM/ldap/V6.2/codeset/852
                        /opt/IBM/ldap/V6.2/codeset/855
                        /opt/IBM/ldap/V6.2/codeset/1025
                        /opt/IBM/ldap/V6.2/codeset/856
                        /opt/IBM/ldap/V6.2/codeset/1026
                        /opt/IBM/ldap/V6.2/codeset/857
                        /opt/IBM/ldap/V6.2/codeset/858
                        /opt/IBM/ldap/V6.2/codeset/859
                        /opt/IBM/ldap/V6.2/codeset/860
                        /opt/IBM/ldap/V6.2/codeset/861
                        /opt/IBM/ldap/V6.2/codeset/862
                        /opt/IBM/ldap/V6.2/codeset/863
                        /opt/IBM/ldap/V6.2/codeset/864
                        /opt/IBM/ldap/V6.2/codeset/865
                        /opt/IBM/ldap/V6.2/codeset/866
                        /opt/IBM/ldap/V6.2/codeset/867
                        /opt/IBM/ldap/V6.2/codeset/869
                        /opt/IBM/ldap/V6.2/bin/idsldapmodrdn
                        /opt/IBM/ldap/V6.2/codeset/SHIFTJIS
                        /opt/IBM/ldap/V6.2/codeset/870
                        /opt/IBM/ldap/V6.2/codeset/871
                        /opt/IBM/ldap/V6.2/codeset/874
                        /opt/IBM/ldap/V6.2/etc/idsinfocenter.html
                        /opt/IBM/ldap/V6.2/codeset/875
                        /opt/IBM/ldap/V6.2/codeset/1046
                        /opt/IBM/ldap/V6.2/codeset/1047
                        /opt/IBM/ldap/V6.2/codeset/878
                        /opt/IBM/ldap/V6.2/bin/ldapchangepwd
                        /opt/IBM/ldap/V6.2/codeset/646
                        /opt/IBM/ldap/V6.2/bin
                        /opt/IBM/ldap/V6.2/codeset/ARABIC8
                        /opt/IBM/ldap/V6.2/codeset/420
                        /opt/IBM/ldap/V6.2/codeset/ISO885913
                        /opt/IBM/ldap/V6.2/codeset/ISO885914
                        /opt/IBM/ldap/V6.2/codeset/424
                        /opt/IBM/ldap/V6.2/codeset/ISO885915
                        /opt/IBM/ldap/V6.2/codeset/GB2312
                        /opt/IBM/ldap/V6.2/codeset/1089
                        /opt/IBM/ldap/V6.2/codeset/437
                        /opt/IBM/ldap/V6.2/codeset/EUCCN
                        /opt/IBM/ldap/V6.2/codeset/1097
                        /opt/IBM/ldap/V6.2/codeset/GB18030
                        /var/idsldap/V6.2
                        /opt/IBM/ldap/V6.2/codeset/ROMAN8
                        /opt/IBM/ldap/V6.2/bin/idsrmlink -> /opt/IBM/ldap/V6.2/bin/idslink
                        /opt/IBM/ldap/V6.2/bin/ldapsearch
                        /opt/IBM/ldap/V6.2/examples
                        /opt/IBM/ldap/V6.2/codeset/EUCJP
                        /opt/IBM/ldap/V6.2/codeset/273
                        /opt/IBM/ldap/V6.2/codeset/274
                        /opt/IBM/ldap/V6.2/codeset/277
                        /opt/IBM/ldap/V6.2/codeset/278
                        /opt/IBM/ldap/V6.2/codeset/EUCKR
                        /opt/IBM/ldap/V6.2/codeset/GBK
                        /opt/IBM/ldap/V6.2/codeset/CNS11643
                        /opt/IBM/ldap/V6.2/codeset/280
                        /opt/IBM/ldap/V6.2/codeset/282
                        /opt/IBM/ldap/V6.2/codeset/284
                        /opt/IBM/ldap/V6.2/codeset/285
                        /opt/IBM/ldap/V6.2/codeset/297
                        /opt/IBM/ldap/V6.2/bin/ldapadd
                        /opt/IBM/ldap/V6.2/bin/idsldapsearch
                        /opt/IBM/ldap/V6.2/bin/idsldapexop
                        /opt/IBM/ldap/V6.2/etc/buildno.txt
                        /opt/IBM/ldap/V6.2/bin/ldapcompare
                        /opt/IBM/ldap/V6.2/etc/ibmldap.conf
                        /opt/IBM/ldap/V6.2/codeset/EUCTW
                        /opt/IBM/ldap/V6.2/bin/ldaptrace
                        /opt/IBM/ldap/V6.2/codeset/912
                        /opt/IBM/ldap/V6.2/codeset/914
                        /opt/IBM/ldap/V6.2/codeset/915
                        /opt/IBM/ldap/V6.2/codeset/916
                        /opt/IBM/ldap/V6.2/codeset/920
                        /opt/IBM/ldap/V6.2/codeset/921
                        /opt/IBM/ldap/V6.2/codeset/922
                        /opt/IBM/ldap/V6.2/codeset/923
                        /opt/IBM/ldap/V6.2/codeset/924
                        /opt/IBM/ldap/V6.2/codeset/930
                        /opt/IBM/ldap/V6.2/codeset/932
                        /opt/IBM/ldap/V6.2/codeset/933
                        /opt/IBM/ldap/V6.2/codeset/935
                        /opt/IBM/ldap/V6.2/codeset/936
                        /opt/IBM/ldap/V6.2/codeset/937
                        /opt/IBM/ldap/V6.2/codeset/939
                        /opt/IBM/ldap/V6.2/bin/idsversion
                        /opt/IBM/ldap/V6.2/codeset/942
                        /opt/IBM/ldap/V6.2/codeset/1112
                        /opt/IBM/ldap/V6.2/codeset/943
                        /opt/IBM/ldap/V6.2/codeset/1116
                        /opt/IBM/ldap/V6.2/codeset/1117
                        /opt/IBM/ldap/V6.2/codeset/949
                        /opt/IBM/ldap/V6.2/codeset/37
                        /opt/IBM/ldap/V6.2/codeset/PCK
                        /opt/IBM/ldap/V6.2/codeset/1363
                        /opt/IBM/ldap/V6.2/codeset/950
                        /opt/IBM/ldap/V6.2/codeset/1122
                        /opt/IBM/ldap/V6.2/codeset/1124
                        /opt/IBM/ldap/V6.2/codeset/1129
                        /opt/IBM/ldap/V6.2/bin/ldapdelete
                        /opt/IBM/ldap/V6.2/codeset/720
                        /opt/IBM/ldap/V6.2/codeset/1381
                        /opt/IBM/ldap/V6.2/codeset/1386
                        /opt/IBM/ldap/V6.2/codeset/1140
                        /opt/IBM/ldap/V6.2/codeset/1388
                        /opt/IBM/ldap/V6.2/codeset/1141
                        /opt/IBM/ldap/V6.2/codeset/1142
                        /opt/IBM/ldap/V6.2/codeset/1143
                        /opt/IBM/ldap/V6.2/codeset/1144
                        /opt/IBM/ldap/V6.2/codeset/1145
                        /opt/IBM/ldap/V6.2/codeset/1146
                        /opt/IBM/ldap/V6.2/codeset/1147
                        /opt/IBM/ldap/V6.2/codeset/1148
                        /opt/IBM/ldap/V6.2/codeset/1149
                        /opt/IBM/ldap/V6.2/codeset/737

Path: /etc/objrepos
  idsldap.cltbase62.rte 6.2.0.32
                        /opt/IBM/ldap/V6.2/etc/ldapkey.sth
                        /opt/IBM/ldap/V6.2/etc/ldapkey.kdb
root[@]tpl-unx-aix71s:/root # lslpp -f idsldap.cltbase62.adt
  Fileset               File
  ----------------------------------------------------------------------------
Path: /usr/lib/objrepos
  idsldap.cltbase62.adt 6.2.0.32
                        /opt/IBM/ldap/V6.2/examples/ldapexop.c
                        /opt/IBM/ldap/V6.2/include/ldif.h
                        /opt/IBM/ldap/V6.2/examples/ldapmodify.c
                        /opt/IBM/ldap/V6.2/examples/ldapchangepwd.c
                        /opt/IBM/ldap/V6.2/include/slapi-plugin.h
                        /opt/IBM/ldap/V6.2/include
                        /opt/IBM/ldap/V6.2/include/audit-plugin.h
                        /opt/IBM/ldap/V6.2/examples/sample.ldif
                        /opt/IBM/ldap/V6.2/include/ldapssl.h
                        /opt/IBM/ldap/V6.2/include/ldaplocale.h
                        /opt/IBM/ldap/V6.2/examples/ldapmodrdn.c
                        /opt/IBM/ldap/V6.2/examples/ldapsearch.c
                        /opt/IBM/ldap/V6.2/examples/makefile.ex
                        /opt/IBM/ldap/V6.2/include/ldap.h
                        /opt/IBM/ldap/V6.2/examples
                        /opt/IBM/ldap/V6.2/examples/ldapdelete.c
                        /opt/IBM/ldap/V6.2/include/audit-plugin-list.h
                        /opt/IBM/ldap/V6.2/include/lber.h
