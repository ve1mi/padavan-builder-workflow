# 1. Меняем версию на master
sed -i 's|^SRC_VER.*|SRC_VER = master|' padavan-ng/trunk/user/nfqws/Makefile

# 2. Подменяем путь в URL: меняем /tags/v$(SRC_VER) на /heads/$(SRC_VER)
# Используем | как разделитель, чтобы не экранировать слэши в URL
sed -i 's|/tags/v$(SRC_VER)|/heads/$(SRC_VER)|' padavan-ng/trunk/user/nfqws/Makefile

# 3. Переходим в папку и очищаем всё, кроме Makefile и патчей
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
