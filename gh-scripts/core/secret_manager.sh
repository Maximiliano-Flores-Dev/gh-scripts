#!/bin/bash
# ===========================================================
# MODULE: SECRET MANAGER (Infrastructure Control)
# ===========================================================

menu_secrets() {
    while true; do
        mostrar_logo
        echo -e "  ${TEXTO_VERDE}[   GESTIÓN DE SECRETOS (ACTIONS) ]${RESET}\n"
        echo -e "  ${TEXTO_VERDE}1#   Listar Secretos Actuales${RESET}"
        echo -e "  ${TEXTO_VERDE}2#   Añadir/Actualizar Secreto${RESET}"
        echo -e "  ${TEXTO_VERDE}3#   Borrar Secreto${RESET}"
        echo -e "  ${TEXTO_VERDE}q# Volver${RESET}\n"

        read -rsn1 -p "  Selección: " s_opt
        case "$s_opt" in
            1) clear; gh secret list ;;
            2) echo -ne "\n  Nombre del Secreto: "; read -r sn
               echo -ne "  Valor: "; read -rs rv # -s para que no se vea lo que escribes
               gh secret set "$sn" --body "$rv" && echo -e "\n  ✅ Guardado."; sleep 1 ;;
            3) echo -ne "\n  Nombre a borrar: "; read -r db
               gh secret delete "$db" && echo -e "  🗑️ Borrado."; sleep 1 ;;
            "q") return ;;
        esac
        echo -e "\n  $L_PRESS_ANY"; read -rsn1
    done
}
