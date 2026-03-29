#!/bin/bash
# ===========================================================
# INSTALLER: GLOBAL IDE v1.0 (Dependencies)
# ===========================================================

echo -e "\e[32m🚀 Iniciando instalación de dependencias...\e[0m"

# Función para instalar en Termux
install_termux() {
    echo "🤖 Detectado entorno Termux. Actualizando paquetes..."
    pkg update && pkg upgrade -y
    pkg install gh fzf jq git ncurses-utils curl -y
}

# Función para instalar en Linux (Debian/Ubuntu)
install_linux() {
    echo "🐧 Detectado entorno Linux. Usando sudo apt..."
    sudo apt update
    sudo apt install gh fzf jq git ncurses-utils curl -y
}

# Detectar OS
if [ -d "/data/data/com.termux" ]; then
    install_termux
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    install_linux
else
    echo "⚠️  OS no soportado automáticamente. Instala: gh, fzf, jq, git manualmente."
fi

# Configurar Nerd Fonts en Termux (Opcional pero recomendado)
if [ -d "/data/data/com.termux" ]; then
    echo -e "\n\e[34m📥 ¿Deseas descargar JetBrainsMono Nerd Font para los iconos? (s/n)\e[0m"
    read -r font_opt
    if [[ "$font_opt" == "s" ]]; then
        mkdir -p ~/.termux
        curl -L https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf -o ~/.termux/font.ttf
        termux-reload-settings
        echo "✅ Fuente instalada. Reinicia Termux para ver los iconos."
    fi
fi

echo -e "\n\e[32m✅ Dependencias listas. Ahora ejecuta: bash setup.sh\e[0m"
