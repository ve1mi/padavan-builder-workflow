#!/bin/bash

# Путь к Makefile внутри склонированного репозитория padavan-ng
MAKEFILE="padavan-ng/trunk/user/nfqws/Makefile"

echo "--- Настройка динамического обновления zapret (nfqws) ---"

# 1. Получаем хэш последнего коммита ветки master через GitHub API
# Используем curl, так как он обычно есть в контейнере builder
LATEST_HASH=$(curl -s https://api.github.com | grep sha | head -n 1 | cut -d '"' -f 4 | cut -c 1-7)

if [ -z "$LATEST_HASH" ]; then
    echo "Ошибка: не удалось получить хэш из GitHub API. Используем заглушку."
    LATEST_HASH="unknown"
fi

echo "Последний хэш: $LATEST_HASH"

# 2. Очищаем старые исходники (кроме Makefile и патчей), чтобы форсировать скачивание master
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
cd - > /dev/null

# 3. Модифицируем Makefile: меняем версию на master и обновляем URL
sed -i "s|^SRC_VER.*|SRC_VER = master|" $MAKEFILE
sed -i "s|^SRC_URL = .*|SRC_URL = https://github.com|" $MAKEFILE

# 4. Подставляем хэш в CFLAGS для корректного отображения версии в бинарнике
sed -i "s|CFLAGS += -DZAPRET_GH_VER=.*|CFLAGS += -DZAPRET_GH_VER=v\$(SRC_VER) -DZAPRET_GH_HASH=$LATEST_HASH|" $MAKEFILE

echo "Makefile успешно обновлен: версия vmaster ($LATEST_HASH)"
echo "--------------------------------------------------------"
