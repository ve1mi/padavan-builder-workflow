# 1. Получаем хеш последнего коммита (например, a1b2c3d)
SHA=$(curl -sH "User-Agent: Firefox" https://api.github.com | jq -r '.sha' | cut -c1-7)

# Если GitHub API не ответил, используем заглушку 'latest', чтобы не было пустоты
[ -z "$SHA" ] && SHA="latest"

# 2. Устанавливаем версию в Makefile (будет выглядеть как SRC_VER = 72.a1b2c3d)
sed -i "s/^SRC_VER.*/SRC_VER = 72.$SHA/" padavan-ng/trunk/user/nfqws/Makefile

# 3. Переходим в папку и чистим старье
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --

# 4. Скачиваем текущий master и называем его так, как ждет Makefile
# ВАЖНО: Мы скачиваем архив ветки master и сохраняем под именем с хешем
curl -LSsH "User-Agent: Firefox" "https://github.com" -o "zapret-72.$SHA.tar.gz"

# 5. Распаковываем в нужную папку, чтобы patch не ругался на отсутствие директории
mkdir -p "zapret-72.$SHA"
tar -xzf "zapret-72.$SHA.tar.gz" -C "zapret-72.$SHA" --strip-components=1
