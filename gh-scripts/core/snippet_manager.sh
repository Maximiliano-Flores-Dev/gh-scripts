#!/bin/bash
# ===========================================================
# MODULE: SNIPPET MANAGER (Nerd Font + Preview + Copy)
# ===========================================================

# Iconos locales
IC_COPY=$(printf '\uf0c5')  # 
IC_EDIT=$(printf '\uf044')  # 
IC_BACK=$(printf '\uf104')  # 
IC_FILE=$(printf '\uf15b')  # 

menu_snippets() {
    while true; do
        mostrar_logo
        echo -e "  ${TEXTO_VERDE}[ ${IC_FILE} GESTOR DE FRAGMENTOS ]${RESET}\n"
        
        if [ -z "$(ls -A "$TEMPLATES_DIR" 2>/dev/null)" ]; then
            echo -e "  ${TEXTO_VERDE}  > Carpeta vacía. Crea uno con [n].${RESET}"
        else
            # Listado con prefijos minimalistas
            local listado=$(ls "$TEMPLATES_DIR" | awk '{
                if ($0 ~ /\.sh$/) icon="[#] ";
                else if ($0 ~ /\.py$/) icon="[P] ";
                else if ($0 ~ /\.js$/) icon="[J] ";
                else icon="[-] ";
                print icon $0
            }')

            # FZF con vista previa heredando el color del tema
            local sel_with_icon=$(echo "$listado" | fzf \
                --height 60% --reverse --border \
                --header="BUSCADOR DE SNIPPETS" \
                --preview "echo -e '${TEXTO_VERDE}'; cat $TEMPLATES_DIR/ \$(echo {} | cut -d' ' -f2-); echo -e '${RESET}'" \
                --preview-window=right:60% \
                --color="fg:${MY_COL},hl:208,info:${MY_COL},prompt:${MY_COL},pointer:${MY_COL},marker:${MY_COL},border:${MY_COL}")

            local sel=$(echo "$sel_with_icon" | cut -d' ' -f2-)

            if [ -n "$sel" ]; then
                clear; mostrar_logo
                echo -e "  ${TEXTO_VERDE}>> SELECCIONADO: ${BOLD}$sel${RESET}\n"
                echo -e "${TEXTO_VERDE}-------------------------------------------"
                cat "$TEMPLATES_DIR/$sel"
                echo -e "-------------------------------------------${RESET}"
                
                echo -e "  ${TEXTO_VERDE}${IC_BACK} [q] VOLVER  |  ${IC_EDIT} [e] EDITAR  |  ${IC_COPY} [c] COPIAR${RESET}"
                
                read -rsn1 opt
                case "$opt" in
                    "e") nano "$TEMPLATES_DIR/$sel" ;;
                    "c") 
                        if command -v termux-clipboard-set &>/dev/null; then
                            cat "$TEMPLATES_DIR/$sel" | termux-clipboard-set
                            echo -e "\n  ${TEXTO_VERDE}${IC_COPY} [✓] COPIADO AL PORTAPAPELES${RESET}"
                        else
                            echo -e "\n  ${TEXTO_VERDE} [!] Error: Instala termux-api${RESET}"
                        fi
                        sleep 1.2 ;;
                esac
                continue
            fi
        fi

        read -rsn1 -p "  (n) Nuevo | (q) Volver: " main_opt
        case "$main_opt" in
            "n") echo -ne "\n  Nombre: "; read -r sn; [ -n "$sn" ] && nano "$TEMPLATES_DIR/$sn" ;;
            "q") return ;;
        esac
    done
}
