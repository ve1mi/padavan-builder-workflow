#sed -i 's/^SRC_VER.*/SRC_VER = 72.3/' padavan-ng/trunk/user/nfqws/Makefile
#cd padavan-ng/trunk/user/nfqws
#find . -maxdepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
cp https://github.com/prostovelikij/padavan-builder-workflow/blob/f50f55fefbb42c6af262fe20b9e3c3ce7e56ddbd/my-kernel.config padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config
