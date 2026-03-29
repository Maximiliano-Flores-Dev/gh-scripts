#!/bin/bash
# ===========================================================
# MODULE: GITHUB ACTIONS (jq Workflow Monitor)
# ===========================================================

view_workflows() {
    clear; mostrar_logo
    echo -e "  ${TEXTO_VERDE}[ ⚙️  ULTIMOS RUNS DE GITHUB ACTIONS ]${RESET}\n"
    
    # Obtenemos los últimos 8 runs del repo actual (si estamos en uno)
    local runs; runs=$(gh api repos/:owner/:repo/actions/runs --limit 8 2>/dev/null)
    
    if [ -z "$runs" ]; then
        echo -e "  ${TEXTO_VERDE}❌ No se detectó un repo de GitHub en esta carpeta.${RESET}"
    else
        # Usamos JQ para limpiar la respuesta y darle formato
        echo "$runs" | jq -r '.workflow_runs[] | "\(.status) | \(.conclusion) | \(.display_title) [\(.head_branch)]"' | while read -r line; do
            # Dar color según el resultado
            if [[ "$line" == *"success"* ]]; then echo -e "  \e[32m✅\e[0m $line"
            elif [[ "$line" == *"failure"* ]]; then echo -e "  \e[31m❌\e[0m $line"
            else echo -e "  \e[33m⏳\e[0m $line"; fi
        done
    fi
    
    echo -e "\n  $L_PRESS_ANY"; read -rsn1
}
