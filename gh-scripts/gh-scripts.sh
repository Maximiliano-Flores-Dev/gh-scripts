#!/bin/bash
# ===========================================================
# SCRIPT: gh-scripts.sh (GLOBAL IDE - v6.6)
# ===========================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CORE_DIR="$SCRIPT_DIR/core"

# 1. CARGAR PREFERENCIAS Y MÓDULOS
CONFIG_FILE="$HOME/.gh_color_pref"; [ -f "$CONFIG_FILE" ] && MY_COL=$(cat "$CONFIG_FILE") || MY_COL=32
LANG_FILE="$HOME/.gh_lang_pref"; [ -f "$LANG_FILE" ] && LANG_ID=$(cat "$LANG_FILE") || LANG_ID="ES"

# Importar todos los módulos de core/
for module in "$CORE_DIR"/*.sh; do source "$module"; done

# 2. INICIALIZAR ENTORNO
reload_colors
load_lang
tput civis
trap "tput cnorm; clear; exit 0" SIGINT SIGTERM

# 3. ICONOS NERD FONTS (Elegantes y adaptativos)
I_PROJ=$(printf '\uf401') #  Proyectos
I_AUTO=$(printf '\uf489') #  Automatizaciones
I_PRRE=$(printf '\uf41a') #  Pull Requests
I_ACTS=$(printf '\uf013') #  GitHub Actions
I_SECR=$(printf '\uf023') #  Secretos / API
I_DASH=$(printf '\uf0e4') #  Dashboard Git
I_SNIP=$(printf '\uf0c5') #  Snippets (fzf)
I_ALIA=$(printf '\uf120') # ⌨ Alias Wizard
I_SETT=$(printf '\uf0ad') # 🔧 Ajustes
I_EXIT=$(printf '\uf08b') #  Salir
I_ARRW=$(printf '\uf105') #  Flecha Selección

# 4. BUCLE PRINCIPAL
cursor=0
while true; do
    mostrar_logo

    # Definición de opciones (Ahora con 10 opciones)
    opc=(
        "$I_PROJ 1# PROYECTOS"
        "$I_AUTO 2# AUTOMATIZACIONES"
        "$I_PRRE 3# PULL REQUESTS"
        "$I_ACTS 4# GH ACTIONS"
        "$I_SECR 5# SECRETOS / API"
        "$I_DASH 6# DASHBOARD GIT"
        "$I_SNIP 7# FRAGMENTOS"
        "$I_ALIA 8# ALIAS WIZARD"
        "$I_SETT 9# AJUSTES"
        "$I_EXIT 10# SALIR"
    )

    total_opc=${#opc[@]}
    for i in "${!opc[@]}"; do
        if [ $i -eq $cursor ]; then
            printf "  ${FONDO_VERDE}  $I_ARRW  %-32s ${RESET}\n" "${opc[$i]}"
        else
            echo -e "  ${TEXTO_VERDE}     ${opc[$i]}${RESET}"
        fi
    done

    draw_status_bar

    # Lógica de navegación y ejecución (Actualizada para 10 posiciones)
    read -rsn3 t; case "$t" in
        $'\e[A') ((cursor--)); [ $cursor -lt 0 ] && cursor=$((total_opc-1)) ;;
        $'\e[B') ((cursor++)); [ $cursor -ge $total_opc ] && cursor=0 ;;
        "")
            case $cursor in
                0) menu_projects ;;       # Proyectos
                1) menu_automations ;;    # Automatizaciones (Tu carpeta local)
                2) menu_pull_requests ;;  # PRs
                3) view_workflows ;;      # Actions
                4) menu_secrets ;;        # Secrets
                5) view_git_status ;;     # Dashboard
                6) menu_snippets ;;       # Snippets (fzf)
                7) menu_alias ;;          # Alias Wizard
                8) menu_settings ;;       # Ajustes
                9) tput cnorm; clear; exit 0 ;; # Salir
            esac
            ;;
    esac
done
