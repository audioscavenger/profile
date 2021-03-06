ident /raid/data/module/ffmpeg.32.1.2.0.1/sys/lib/libssl.so.1.0.0

nm -DC /raid/data/module/ffmpeg.32.1.2.0.1/sys/lib/libssl.so.1.0.0|head
         U ASN1_INTEGER_get
         U ASN1_INTEGER_set
         U ASN1_const_check_infinite_end

readelf --symbols /raid/data/module/ffmpeg.32.1.2.0.1/sys/lib/libssl.so.1.0.0|head
Symbol table '.dynsym' contains 902 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
     0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: 00039ed0    19 FUNC    GLOBAL DEFAULT   10 SSL_renegotiate_pending
     2: 00038150   220 FUNC    GLOBAL DEFAULT   10 dtls1_send_change_cipher_
     3: 0003d850    46 FUNC    GLOBAL DEFAULT   10 SSL_CTX_set1_param
     4: 00000000     0 FUNC    GLOBAL DEFAULT  UND RSAPrivateKey_dup
     5: 0003af00    60 FUNC    GLOBAL DEFAULT   10 SSL_CTX_set_cert_store
     6: 00000000     0 FUNC    GLOBAL DEFAULT  UND abort@GLIBC_2.0 (2)

strip --strip-unneeded libtest.o
# --strip-all is safe on shared libraries, because global symbols remain in a separate section, but not on objects for inclusion in static libraries (relocatable objects). --strip-unneeded is safe for both, and automatically understands shared objects do not need any .symtab entries to function and removes them; effectively doing the same work as --strip-all. So, --strip-unneeded is essentially the only tool you need for standard stripping needs!

readelf --symbols /data/Development/Home/Thecus/Build/ROOT.DEV32/raid/data/module/ModBase1/system/lib/libssl.so.1.0.0|head
Symbol table '.dynsym' contains 818 entries:
   Num:    Value  Size Type    Bind   Vis      Ndx Name
     0: 00000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: 000341c0    16 FUNC    GLOBAL DEFAULT   10 SSL_renegotiate_pending
     2: 00032c40   220 FUNC    GLOBAL DEFAULT   10 dtls1_send_change_cipher_
     3: 00037830    46 FUNC    GLOBAL DEFAULT   10 SSL_CTX_set1_param
     4: 00000000     0 FUNC    GLOBAL DEFAULT  UND RSAPrivateKey_dup
     5: 00035070    60 FUNC    GLOBAL DEFAULT   10 SSL_CTX_set_cert_store
     6: 00000000     0 FUNC    GLOBAL DEFAULT  UND __errno_location@GLIBC_2.0 (2)

