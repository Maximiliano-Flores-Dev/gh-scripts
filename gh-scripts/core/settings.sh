#!/bin/bash
# ===========================================================
# MODULE: SETTINGS MENU
# ===========================================================

settings_language() {
    local other; [ "$LANG_ID" == "ES" ] && other="EN" || other="ES"
    clear; mostrar_logo
    echo -e "  ${TEXTO_VERDE}$L_LANG_CURR  : ${BOLD}$LANG_ID${RESET}"
    echo -e "  ${TEXTO_VERDE}$L_LANG_SWITCH: ${BOLD}$other${RESET}\n"
    echo -ne "  ${TEXTO_VERDE}$L_CONFIRM: ${RESET}"; read -r c
    if [[ "$c" =~ ^[ysYS1sS]$ ]]; then
        LANG_ID="$other"; echo "$LANG_ID" > "$LANG_FILE"; load_lang
    fi
}

set_ui_color() {
    clear; echo -e "${BOLD}🎨  COLOR PALETTE${RESET}\n"
    for i in {0..255}; do
        printf "\e[48;5;%dm %3d \e[0m" "$i" "$i"
        [ $(((i + 1) % 10)) -eq 0 ] && echo ""
    done
    echo -ne "\nColor ID (0-255): "; read -r c
    if [[ "$c" =~ ^[0-9]+$ ]] && [ "$c" -le 255 ]; then
        MY_COL="$c"; echo "$MY_COL" > "$CONFIG_FILE"; reload_colors
    fi
}

menu_settings() {
    local s_cursor=0
    while true; do
        local sopc=("$L_S0" "$L_S1" "$L_S2" "$L_S3" "$L_S4" "$L_S5" "$L_S6")
        mostrar_logo
        for i in "${!sopc[@]}"; do
            [ $i -eq $s_cursor ] && printf "  ${FONDO_VERDE}  ▶  %-32s ${RESET}\n" "${sopc[$i]}" || echo -e "  ${TEXTO_VERDE}     ${sopc[$i]}${RESET}"
        done
        draw_status_bar
        read -rsn3 t; case "$t" in
            $'\e[A') ((s_cursor--)); [ $s_cursor -lt 0 ] && s_cursor=6 ;;
            $'\e[B') ((s_cursor++)); [ $s_cursor -gt 6 ] && s_cursor=0 ;;
            "") case $s_cursor in
                0) settings_language ;; 1) manage_gh_auth ;; 2) manage_official_repo ;;
                3) check_dependencies ;; 4) settings_paths ;; 5) set_ui_color ;; 6) return ;;
            esac ;;
            "q") return ;;
        esac
    done
}
