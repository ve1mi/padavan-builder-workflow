sed -i 's/^SRC_VER.*/SRC_VER = 72.9/' padavan-ng/trunk/user/nfqws/Makefile
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
