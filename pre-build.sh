# 1. Получаем хэш
COMMIT_HASH=$(curl -s https://api.github.com | grep sha | head -n 1 | cut -d '"' -f 4 | cut -c1-7)
[ -z "$COMMIT_HASH" ] && COMMIT_HASH="master"

# 2. Правим Makefile: устанавливаем версию master и ПРЯМОЙ URL
# Используем флаг -L для wget (через правку Makefile) или меняем формат ссылки
sed -i 's|^SRC_VER.*|SRC_VER = master|' padavan-ng/trunk/user/nfqws/Makefile
sed -i 's|SRC_URL = .*|SRC_URL = https://codeload.github.com|' padavan-ng/trunk/user/nfqws/Makefile

# 3. Инъекция хэша в CFLAGS для отображения в логах
sed -i "s|DZAPRET_GH_VER=v\$(SRC_VER)|DZAPRET_GH_VER=vmaster|g" padavan-ng/trunk/user/nfqws/Makefile
sed -i "s|DZAPRET_GH_HASH=release|DZAPRET_GH_HASH=$COMMIT_HASH|g" padavan-ng/trunk/user/nfqws/Makefile

# 4. Исправляем команду wget в самом Makefile (добавляем -L для обработки редиректов GitHub)
sed -i 's/wget -t5/wget -L -t5/g' padavan-ng/trunk/user/nfqws/Makefile

# 5. Очистка перед сборкой
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
