#!/bin/bash
# ===========================================================
# MODULE: AUTOMATIONS (Local Scripts Runner)
# ===========================================================

menu_automations() {
    while true; do
        mapfile -t scripts < <(ls "$AUTOS_DIR"/*.sh 2>/dev/null | xargs -n 1 basename 2>/dev/null)
        local items=("${scripts[@]}" "(+)")
        local a_cursor=0
        local total=${#items[@]}

        while true; do
            mostrar_logo
            echo -e "  ${TEXTO_VERDE}[ 🚀 $L_OPT_1 ]${RESET}\n"

            for (( i=0; i<total; i+=2 )); do
                for (( j=i; j<i+2 && j<total; j++ )); do
                    if [ "${items[$j]}" == "(+)" ]; then dibujar_boton_plus "top"; else echo -ne "${TEXTO_VERDE} ╭──────────────────╮ ${RESET}"; fi
                done; echo ""
                for (( j=i; j<i+2 && j<total; j++ )); do
                    render_grid_item "${items[$j]}" "$j" "$a_cursor"
                done; echo ""
                for (( j=i; j<i+2 && j<total; j++ )); do
                    if [ "${items[$j]}" == "(+)" ]; then dibujar_boton_plus "bot"; else echo -ne "${TEXTO_VERDE} ╰──────────────────╯ ${RESET}"; fi
                done; echo ""
            done

            draw_status_bar
            read -rsn3 k; case "$k" in
                $'\e[A') ((a_cursor-=2)) ;; $'\e[B') ((a_cursor+=2)) ;;
                $'\e[D') ((a_cursor--)) ;; $'\e[C') ((a_cursor++)) ;;
                "") if [ "${items[$a_cursor]}" == "(+)" ]; then
                        read -p "Script Name: " n; [ -n "$n" ] && echo "#!/bin/bash" > "$AUTOS_DIR/$n.sh" && chmod +x "$AUTOS_DIR/$n.sh" && break
                    else clear; bash "$AUTOS_DIR/${items[$a_cursor]}"; read -p "$L_PRESS_ANY"; break; fi ;;
                "q") return ;;
            esac
            [ $a_cursor -lt 0 ] && a_cursor=0
            [ $a_cursor -ge $total ] && a_cursor=$((total-1))
        done
    done
}
