# 1. Получаем хэш последнего коммита (7 символов) через GitHub API
LAST_HASH=$(curl -s https://api.github.com | grep sha | head -n 1 | cut -d '"' -f 4 | cut -c1-7)

# 2. Подставляем хэш в переменную SRC_VER (вместо фиксированного числа)
sed -i "s/^SRC_VER.*/SRC_VER = $LAST_HASH/" padavan-ng/trunk/user/nfqws/Makefile

# 3. Убираем из URL привязку к тегам 'refs/tags/v', чтобы GitHub отдавал архив по хэшу
sed -i 's|archive/refs/tags/v|archive/|g' padavan-ng/trunk/user/nfqws/Makefile

# 4. Ваш оригинальный блок очистки
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
