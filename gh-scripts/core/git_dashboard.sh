#!/bin/bash
# ===========================================================
# MODULE: GIT DASHBOARD (Status Quickview)
# ===========================================================

view_git_status() {
    clear; mostrar_logo
    echo -e "  ${TEXTO_VERDE}[   DASHBOARD DE ESTADO ]${RESET}\n"
    
    echo -e "  ${BOLD}📦 RAMA ACTUAL:${RESET} $(git branch --show-current 2>/dev/null || echo 'N/A')"
    echo -e "  ${BOLD}  COMMITS HOY:${RESET} $(git log --oneline --since="midnight" | wc -l)"
    echo -e "  ${BOLD}  PENDIENTES DE PUSH:${RESET} $(git cherry -v | wc -l)"
    
    echo -e "\n  ${TEXTO_VERDE}--- ARCHIVOS MODIFICADOS ---${RESET}"
    git status -s || echo "No es un repositorio Git"
    
    echo -e "\n  $L_PRESS_ANY"; read -rsn1
}
