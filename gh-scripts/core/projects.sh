#!/bin/bash
# ===========================================================
# MODULE: PROJECTS (GitHub Repos Manager)
# ===========================================================

menu_projects() {
    while true; do
        # Obtener lista de repos (limite 14 + botón plus)
        mapfile -t repos < <(gh repo list --limit 14 | awk '{print $1}' | cut -d'/' -f2)
        local items=("${repos[@]}" "(+)")
        local p_cursor=0
        local total=${#items[@]}

        while true; do
            mostrar_logo
            echo -e "  ${TEXTO_VERDE}[ 📂 $L_OPT_0 ]${RESET}\n"

            for (( i=0; i<total; i+=2 )); do
                # TOPS
                for (( j=i; j<i+2 && j<total; j++ )); do
                    if [ "${items[$j]}" == "(+)" ]; then dibujar_boton_plus "top"; else echo -ne "${TEXTO_VERDE} ╭──────────────────╮ ${RESET}"; fi
                done; echo ""
                # MIDS
                for (( j=i; j<i+2 && j<total; j++ )); do
                    render_grid_item "${items[$j]}" "$j" "$p_cursor"
                done; echo ""
                # BOTS
                for (( j=i; j<i+2 && j<total; j++ )); do
                    if [ "${items[$j]}" == "(+)" ]; then dibujar_boton_plus "bot"; else echo -ne "${TEXTO_VERDE} ╰──────────────────╯ ${RESET}"; fi
                done; echo ""
            done

            draw_status_bar
            read -rsn3 k; case "$k" in
                $'\e[A') ((p_cursor-=2)) ;; $'\e[B') ((p_cursor+=2)) ;;
                $'\e[D') ((p_cursor--)) ;; $'\e[C') ((p_cursor++)) ;;
                "") if [ "${items[$p_cursor]}" == "(+)" ]; then
                        read -p "Repo Name: " n; [ -n "$n" ] && gh repo create "$n" --public --confirm && break
                    else gh repo view "${items[$p_cursor]}" --web; break; fi ;;
                "q") return ;;
            esac
            [ $p_cursor -lt 0 ] && p_cursor=0
            [ $p_cursor -ge $total ] && p_cursor=$((total-1))
        done
    done
}
