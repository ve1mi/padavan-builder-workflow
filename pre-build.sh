# Включение 8 МБ флеш: CONFIG_RT2880_FLASH_8M=y и отключение 16 МБ
sed -i 's/^# CONFIG_RT2880_FLASH_8M is not set/CONFIG_RT2880_FLASH_8M=y/' padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config
sed -i 's/^CONFIG_RT2880_FLASH_16M=.*/# CONFIG_RT2880_FLASH_16M is not set/' padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config

sed -i 's/^SRC_VER.*/SRC_VER = 72.3/' padavan-ng/trunk/user/nfqws/Makefile
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
