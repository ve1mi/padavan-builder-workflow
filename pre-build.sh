# 1. Получаем актуальный короткий хэш из GitHub API
# Это позволит заменить "master" на реальный номер (напр. 7a2b3c4)
COMMIT_HASH=$(curl -s https://api.github.com | grep sha | head -n 1 | cut -d '"' -f 4 | cut -c1-7)

# Если API недоступно, ставим заглушку, чтобы не сломать сборку
[ -z "$COMMIT_HASH" ] && COMMIT_HASH="master"

# 2. Устанавливаем версию (теперь здесь будет хэш вместо слова master)
sed -i "s|^SRC_VER.*|SRC_VER = $COMMIT_HASH|" padavan-ng/trunk/user/nfqws/Makefile

# 3. Подменяем URL (ссылка на master всегда отдает актуальный код)
sed -i 's|SRC_URL = .*|SRC_URL = https://github.com/bol-van/zapret/archive/refs/heads/master.tar.gz|' padavan-ng/trunk/user/nfqws/Makefile

# 4. Переходим и очищаем старые файлы
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
