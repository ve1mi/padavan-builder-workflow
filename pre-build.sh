# 1. Получаем дату последнего коммита для версии
LATEST_DATE=$(curl -s https://api.github.com | jq -r '.commit.committer.date' | cut -d'T' -f1 | tr -d '-')
LATEST_VER="72.$LATEST_DATE"

# 2. Путь к папке nfqws
PKG_DIR="padavan-ng/trunk/user/nfqws"

# 3. Обновляем версию в Makefile
sed -i "s/^SRC_VER.*/SRC_VER = $LATEST_VER/" "$PKG_DIR/Makefile"

# 4. Очищаем папку от старых файлов (кроме Makefile и патчей)
cd "$PKG_DIR"
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --

# 5. СКАЧИВАЕМ АКТУАЛЬНЫЙ MASTER И ПОДМЕНЯЕМ ИМ РЕЛИЗ
# Мы скачиваем текущий срез кода и называем его так, как ждет Makefile
curl -L "https://github.com/bol-van/zapret/archive/refs/heads/master.tar.gz" -o "zapret-$LATEST_VER.tar.gz"
