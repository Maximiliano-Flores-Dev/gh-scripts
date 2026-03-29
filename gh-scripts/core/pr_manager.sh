#!/bin/bash
# ===========================================================
# MODULE: PR MANAGER (Nerd Font + fzf)
# ===========================================================

menu_pull_requests() {
    while true; do
        mostrar_logo
        echo -e "  ${TEXTO_VERDE}[   GESTIÓN DE PULL REQUESTS ]${RESET}\n"

        # Listar PRs abiertos del repo actual
        local pr_list=$(gh pr list --limit 10 --json number,title,author,headRefName 2>/dev/null | jq -r '.[] | "#\(.number) | \(.author.login) | \(.title)"')

        if [ -z "$pr_list" ]; then
            echo -e "  ${TEXTO_VERDE}  > No hay PRs abiertos o no estás en un repo.${RESET}"
            echo -e "\n  $L_PRESS_ANY"; read -rsn1; return
        else
            local sel=$(echo "$pr_list" | fzf --height 50% --reverse --border \
                --header="SELECCIONA UN PR PARA INSPECCIONAR" \
                --preview "gh pr view \$(echo {} | cut -d'#' -f2 | cut -d' ' -f1)" \
                --preview-window=right:65% --color="fg:${MY_COL}")

            [ -z "$sel" ] && return
            local pr_num=$(echo "$sel" | cut -d'#' -f2 | cut -d' ' -f1)

            echo -e "\n  ${TEXTO_VERDE} [1] Checkout (Rama)  [2] Navegador  [3] Aprobar  [q] Volver${RESET}"
            read -rsn1 pr_opt
            case "$pr_opt" in
                1) gh pr checkout "$pr_num" && sleep 1 ;;
                2) gh pr view "$pr_num" --web ;;
                3) echo -ne "\n  Mensaje: "; read -r m; gh pr review "$pr_num" --approve -b "$m" ;;
            esac
        fi
    done
}
