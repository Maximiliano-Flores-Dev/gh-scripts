#!/bin/bash
# ===========================================================
# MODULE: DOC VIEWER (Markdown Reader)
# ===========================================================

md_viewer() {
    while true; do
        mostrar_logo
        echo -e "  ${TEXTO_VERDE}[ 📖 $L_OPT_2 ]${RESET}\n"
        mapfile -t docs < <(ls "$DOCS_DIR"/*.md 2>/dev/null)
        
        if [ ${#docs[@]} -eq 0 ]; then
            echo -e "  ${TEXTO_VERDE}⚠ No .md files found in: $DOCS_DIR${RESET}"
        else
            for i in "${!docs[@]}"; do
                echo -e "  ${TEXTO_VERDE}$i) 📄 $(basename "${docs[$i]}")${RESET}"
            done
        fi
        
        echo -e "\n  ${TEXTO_VERDE}Enter ID to view or 'q' to go back${RESET}"
        draw_status_bar
        read -p "> " sel
        [ "$sel" == "q" ] && break
        if [[ -n "$sel" && -f "${docs[$sel]}" ]]; then
            clear
            sed "s/^/${TEXTO_VERDE}/" "${docs[$sel]}" | less -R
        fi
    done
}
