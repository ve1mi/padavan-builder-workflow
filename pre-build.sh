# 1. Устанавливаем версию (хэш)
sed -i 's|^SRC_VER.*|SRC_VER = 53eba04|' padavan-ng/trunk/user/nfqws/Makefile

# 2. Меняем URL на архив конкретного коммита
sed -i 's|SRC_URL = .*|SRC_URL = https://github.com|' padavan-ng/trunk/user/nfqws/Makefile

# 3. Важно: GitHub распакует это в папку "zapret-хэш", подправляем SRC_DIR
sed -i 's|^SRC_DIR.*|SRC_DIR = zapret-53eba046ce1b6b8219bbefca6952dcc1c7bfb436|' padavan-ng/trunk/user/nfqws/Makefile

# 4. Очистка старых исходников
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
