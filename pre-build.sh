sed -i 's/^SRC_VER.*/SRC_VER = 72.3/' padavan-ng/trunk/user/nfqws/Makefile
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
# cp "$GITHUB_WORKSPACE/my-kernel.config" padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config
sed -i \
    -e 's/^CONFIG_RT2880_FLASH_16M=y/# CONFIG_RT2880_FLASH_16M is not set/' \
    -e 's/^# CONFIG_RT2880_FLASH_8M is not set/CONFIG_RT2880_FLASH_8M=y/' \
    padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config
    
# Замена CONFIG_MTD_STORE_PART_SIZ с 0x40000 на 0x20000
sed -i 's/^CONFIG_MTD_STORE_PART_SIZ=.*/CONFIG_MTD_STORE_PART_SIZ=0x20000/' padavan-ng/trunk/configs/boards/XIAOMI/MI-MINI/kernel-3.4.x.config
