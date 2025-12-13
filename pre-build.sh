# Обновление nfqws
sed -i 's/^SRC_VER.*/SRC_VER = 72.3/' padavan-ng/trunk/user/nfqws/Makefile
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 ! -name Makefile ! -name patches -print0 | xargs -0 rm -rf --

# Настройка конфигурации для ASUS RT-N14U (8 МБ флеш)
CONFIG_FILE="padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config"

# Гарантированно устанавливаем 8M, отключаем 16M
sed -i '/CONFIG_RT2880_FLASH_8M\|CONFIG_RT2880_FLASH_16M/d' "$CONFIG_FILE"
echo "CONFIG_RT2880_FLASH_8M=y" >> "$CONFIG_FILE"
echo "# CONFIG_RT2880_FLASH_16M is not set" >> "$CONFIG_FILE"
