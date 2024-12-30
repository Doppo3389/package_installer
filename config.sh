#!/bin/bash

# Список пакетов для установки
pack_list=(git curl htop openvpn virtualbox docker firefox flameshot mattermost-desktop telegram-desktop code postgresql)

# Менеджеры пакетов для разных дистрибутивов
declare -A package_managers
package_managers["debian"]="apt-get"
package_managers["arch"]="pacman"

# Функция для обновления и установки пакетов
install_packages() {
    local manager=$1
    local update_command=$2
    local install_command=$3

    sudo $manager $update_command
    sudo $manager $install_command "${pack_list[@]}"
}

# Меню выбора
echo "Выберите дистрибутив:"
echo "1. Debian/Ubuntu"
echo "2. ArchLinux"
read choice

case $choice in
    1)
        install_packages ${package_managers["debian"]} "update" "install -y"
        ;;
    2)
        install_packages ${package_managers["arch"]} "-Syu" "-S --noconfirm"
        ;;
    *)
        echo "Неверный выбор"
        exit 1
        ;;
esac

# Проверка версии Python
python3 --version
