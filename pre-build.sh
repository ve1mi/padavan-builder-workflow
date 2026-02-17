# 1. Получаем дату последнего коммита в формате ГГГГ.ММ.ДД (например, 72.20250216)
# Используем ветку master как самую актуальную
LAST_COMMIT_DATE=$(curl -s https://api.github.com | grep -oP '"date": "\K[^T]+' | tr -d '-')
LATEST_VER="72.$LAST_COMMIT_DATE"

# 2. Обновляем Makefile
sed -i "s/^SRC_VER.*/SRC_VER = $LATEST_VER/" padavan-ng/trunk/user/nfqws/Makefile

# 3. Очистка и переход
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
