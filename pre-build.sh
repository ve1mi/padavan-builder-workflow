sed -i 's/^SRC_VER.*/SRC_VER = 72.3/' padavan-ng/trunk/user/nfqws/Makefile
cd padavan-ng/trunk/user/nfqws
find . -maxdepth 1 -not -name Makefile -not -name patches -print0 | xargs -0 rm -rf --
cat > padavan-ng/trunk/configs/boards/ASUS/RT-N14U/kernel-3.4.x.config << 'EOF'
# Ваш полный kernel config здесь
CONFIG_RT2880_FLASH_8M=y
# CONFIG_RT2880_FLASH_16M is not set
...остальное содержимое...
EOF

echo "[pre-build.sh] Kernel config written inline"
