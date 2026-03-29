#!/bin/bash
# ===========================================================
# MODULE: UTILS (Grid Engines & Helpers)
# ===========================================================

# Motor para dibujar los botones de "Crear (+)"
dibujar_boton_plus() {
    local parte=$1
    case $parte in
        "top") echo -ne "${TEXTO_VERDE}      ╭──────╮      ${RESET}" ;;
        "mid") echo -ne "${TEXTO_VERDE}      │${RESET}  ➕  ${TEXTO_VERDE}│      ${RESET}" ;;
        "bot") echo -ne "${TEXTO_VERDE}      ╰──────╯      ${RESET}" ;;
    esac
}

# Verificador de dependencias
check_dependencies() {
    clear; mostrar_logo
    local deps=("gh" "git" "fzf" "jq" "curl")
    echo -e "  ${BOLD}DEPENDENCY CHECK${RESET}\n"
    for dep in "${deps[@]}"; do
        if command -v "$dep" &>/dev/null; then
            echo -e "  \e[32m✅ $dep\e[0m is installed"
        else
            echo -e "  \e[31m❌ $dep\e[0m is missing"
        fi
    done
    echo -e "\n  $L_PRESS_ANY"; read -rsn1
}

# Lógica compartida para renderizar cuadrículas (Grid Render)
render_grid_item() {
    local item=$1
    local index=$2
    local cursor_pos=$3
    local style=$RESET
    [ $index -eq $cursor_pos ] && style=$FONDO_VERDE

    if [ "$item" == "(+)" ]; then
        if [ $index -eq $cursor_pos ]; then
             echo -ne "${TEXTO_VERDE}      │${FONDO_VERDE}  ➕  ${RESET}${TEXTO_VERDE}│      ${RESET}"
        else
             dibujar_boton_plus "mid"
        fi
    else
        printf " ${TEXTO_VERDE}│${RESET} ${style}%-16.16s${RESET} ${TEXTO_VERDE}│${RESET} " "$item"
    fi
}
