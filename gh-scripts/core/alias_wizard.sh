#!/bin/bash
# ===========================================================
# MODULE: ALIAS WIZARD
# ===========================================================

menu_alias() {
    while true; do
        mostrar_logo
        echo -e "  ${TEXTO_VERDE}[ 🧙 ALIAS WIZARD ]${RESET}\n"
        echo -e "  ${TEXTO_VERDE}1# Ver alias actuales${RESET}"
        echo -e "  ${TEXTO_VERDE}2# Añadir nuevo alias (Temp)${RESET}"
        echo -e "  ${TEXTO_VERDE}q# Volver${RESET}\n"
        
        read -rsn1 -p "  Selección: " opt
        case "$opt" in
            1) clear; alias | fzf --height 60% --border --header="TUS ALIAS ACTIVOS" ; read -p "$L_PRESS_ANY" ;;
            2) echo -ne "\n  Comando (ej: g): "; read -r cmd
               echo -ne "  Acción (ej: git status): "; read -r acc
               alias "$cmd"="$acc"
               echo -e "  ✅ Alias '$cmd' creado para esta sesión."; sleep 1 ;;
            "q") return ;;
        esac
    done
}
