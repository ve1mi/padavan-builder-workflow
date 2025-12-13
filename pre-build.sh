# Обновление nfqws
sed -i 's/^SRC_VER.*/SRC_VER = 72.3/' padavan-ng/trunk/user/nfqws/Makefile
cd padavan-ng/trunk/user/nfqws

# Безопасная очистка (не трогает . и ..)
find . -mindepth 1 -maxdepth 1 ! -name Makefile ! -name patches -print0 | xargs -0 rm -rf --

cd -  # возврат в исходную директорию

# УКАЖИ ПРАВИЛЬНОЕ ИМЯ ПЛАТЫ! Например, RTN14U вместо RT-N14U
BOARD_DIR="padavan-ng/trunk/configs/boards/ASUS/RTN14U"  # ← ПРОВЕРЬ ЭТО!

if [ ! -d "$BOARD_DIR" ]; then
  echo "ERROR: Board directory not found: $BOARD_DIR" >&2
  exit 1
fi

CONFIG_FILE="$BOARD_DIR/kernel-3.4.x.config"

# Настройка флеш-памяти: 8 МБ
sed -i 's/^# CONFIG_RT2880_FLASH_8M is not set/CONFIG_RT2880_FLASH_8M=y/' "$CONFIG_FILE"
sed -i 's/^CONFIG_RT2880_FLASH_16M=.*/# CONFIG_RT2880_FLASH_16M is not set/' "$CONFIG_FILE"
