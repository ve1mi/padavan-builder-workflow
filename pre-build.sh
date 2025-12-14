# Включение 8 МБ флеш: CONFIG_RT2880_FLASH_8M=y и отключение 16 МБ
sed -i 's/^# CONFIG_RT2880_FLASH_8M is not set/CONFIG_RT2880_FLASH_8M=y/' padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config
sed -i 's/^CONFIG_RT2880_FLASH_16M=.*/# CONFIG_RT2880_FLASH_16M is not set/' padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config

# Замена CONFIG_RT2880_MTD_PHYSMAP_LEN с 0x1000000 на 0x800000
#sed -i 's/^CONFIG_RT2880_MTD_PHYSMAP_LEN=.*/CONFIG_RT2880_MTD_PHYSMAP_LEN=0x800000/' padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config

# Замена CONFIG_MTD_STORE_PART_SIZ с 0x40000 на 0x10000
#sed -i 's/^CONFIG_MTD_STORE_PART_SIZ=.*/CONFIG_MTD_STORE_PART_SIZ=0x10000/' padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config

sed -i 's/pt_ralink_16m\.config/pt_ralink_8m_bigstor.config/' padavan-ng/trunk/configs/boards/ASUS/RT-N14U/partitions.config

sed -i 's/^SRC_VER.*/SRC_VER = 72.4/' padavan-ng/trunk/user/nfqws/Makefile
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --

