# 1. Получаем дату последнего коммита (ГГГГ.ММ.ДД) через заголовок или API
# Если curl не сработает, поставим заглушку, чтобы сборка не упала с пустой строкой
LATEST_DATE=$(curl -s https://api.github.com | jq -r '.commit.committer.date' | cut -d'T' -f1 | tr -d '-')

if [ -z "$LATEST_DATE" ]; then
  echo "Ошибка: Не удалось получить дату. Используем текущую."
  LATEST_DATE=$(date +%Y%m%d)
fi

LATEST_VER="72.$LATEST_DATE"

# 2. Обновляем Makefile (используем двойные кавычки!)
sed -i "s/^SRC_VER.*/SRC_VER = $LATEST_VER/" padavan-ng/trunk/user/nfqws/Makefile

# 3. Очистка (как у вас)
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -mindepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
