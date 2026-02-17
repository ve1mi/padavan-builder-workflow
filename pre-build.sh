# 1. Получаем актуальный хэш мастер-ветки
COMMIT_HASH=$(curl -s https://api.github.com | grep sha | head -n 1 | cut -d '"' -f 4 | cut -c1-7)
[ -z "$COMMIT_HASH" ] && COMMIT_HASH="master"

# 2. Устанавливаем версию master и правильный URL (через подмену SRC_VER)
sed -i 's|^SRC_VER.*|SRC_VER = master|' padavan-ng/trunk/user/nfqws/Makefile
sed -i 's|SRC_URL = .*|SRC_URL = https://github.com|' padavan-ng/trunk/user/nfqws/Makefile

# 3. ПОДМЕНЯЕМ ВЫВОД ВЕРСИИ: меняем макросы CFLAGS
# Вместо v$(SRC_VER) подставляем vmaster, а вместо release — наш хэш
sed -i "s|DZAPRET_GH_VER=v\$(SRC_VER)|DZAPRET_GH_VER=vmaster|g" padavan-ng/trunk/user/nfqws/Makefile
sed -i "s|DZAPRET_GH_HASH=release|DZAPRET_GH_HASH=$COMMIT_HASH|g" padavan-ng/trunk/user/nfqws/Makefile

# 4. Переходим и очищаем старые файлы (как в вашем исходном коде)
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
