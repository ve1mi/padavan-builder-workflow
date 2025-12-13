sed -i 's/^SRC_VER.*/SRC_VER = 72.3/' padavan-ng/trunk/user/nfqws/Makefile
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
cp "$GITHUB_WORKSPACE/my-kernel.config" "$GITHUB_WORKSPACE/padavan/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config"
