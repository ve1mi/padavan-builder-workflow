#!/bin/bash

# Настройки репозитория zapret
REPO_OWNER="bol-van"
REPO_NAME="zapret"
MAKEFILE="padavan-ng/trunk/user/nfqws/Makefile"

echo "--- Настройка динамического обновления zapret (nfqws) ---"

# 1. Получаем хэш последнего коммита именно для этого репозитория
# Добавлен конкретный путь к API репозитория
LATEST_HASH=$(curl -s "https://api.github.com" | grep '"sha"' | head -n 1 | cut -d '"' -f 4 | cut -c 1-7)

if [ -z "$LATEST_HASH" ]; then
    echo "Ошибка: не удалось получить хэш. Используем заглушку."
    LATEST_HASH="unknown"
fi

echo "Последний хэш: $LATEST_HASH"

# 2. Очищаем старые исходники
# Это важно, чтобы старые папки типа zapret-v1.x не мешали накладывать патчи на master
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
cd - > /dev/null

# 3. Модифицируем Makefile
# SRC_URL теперь указывает на эндпоинт архивов GitHub
# Makefile в Padavan обычно формирует ссылку как $(SRC_URL)/$(SRC_VER).tar.gz
sed -i "s|^SRC_VER.*|SRC_VER = master|" $MAKEFILE
sed -i "s|^SRC_URL = .*|SRC_URL = https://github.com|" $MAKEFILE

# 4. Подставляем хэш в CFLAGS
# Исправлено: экранирование и корректная подстановка переменной
sed -i "s|CFLAGS += -DZAPRET_GH_VER=.*|CFLAGS += -DZAPRET_GH_VER=v\$(SRC_VER) -DZAPRET_GH_HASH=$LATEST_HASH|" $MAKEFILE

echo "Makefile успешно обновлен: версия vmaster ($LATEST_HASH)"
echo "URL загрузки: https://github.com/master.tar.gz"
echo "--------------------------------------------------------"
