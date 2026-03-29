#!/bin/bash
# ===========================================================
# MODULE: CONFIG MANAGER (Colors, Lang & Paths)
# ===========================================================

reload_colors() {
    TEXTO_VERDE="\e[38;5;${MY_COL}m"
    FONDO_VERDE="\e[48;5;${MY_COL}m\e[30m"
    RESET="\e[0m"
    BOLD="\e[1m"
}

load_lang() {
    if [ "$LANG_ID" == "ES" ]; then
        # Main
        L_OPT_0="1# PROYECTOS"; L_OPT_1="2# AUTOMATIZACIONES"; L_OPT_2="3# DOCUMENTACIÓN"; L_OPT_3="4# AJUSTES"; L_OPT_4="5# SALIR"
        # Settings labels
        L_SET_TITLE="PANEL DE AJUSTES"; L_S0="1# IDIOMA"; L_S1="2# GITHUB CLI"; L_S2="3# REPOSITORIO"; L_S3="4# DEPENDENCIAS"; L_S4="5# RUTAS"; L_S5="6# COLOR"; L_S6="7# VOLVER"
        L_LANG_CURR="Idioma actual"; L_LANG_SWITCH="Cambiar a"
        L_LOGGED_AS="Sesión activa como"; L_NOT_LOGGED="Sin autenticación"
        L_CONFIRM="(s/n)"; L_PRESS_ANY="[Presiona una tecla]"; L_NAVIGATE="[↑↓] Navegar [Enter] Ok [q] Volver"
    else
        L_OPT_0="1# PROJECTS"; L_OPT_1="2# AUTOMATIONS"; L_OPT_2="3# DOCUMENTATION"; L_OPT_3="4# SETTINGS"; L_OPT_4="5# QUIT"
        L_SET_TITLE="SETTINGS PANEL"; L_S0="1# LANGUAGE"; L_S1="2# GITHUB CLI"; L_S2="3# OFFICIAL REPO"; L_S3="4# DEPENDENCIES"; L_S4="5# PATHS"; L_S5="6# COLOR"; L_S6="7# BACK"
        L_LANG_CURR="Current language"; L_LANG_SWITCH="Switch to"
        L_LOGGED_AS="Logged in as"; L_NOT_LOGGED="Not authenticated"
        L_CONFIRM="(y/n)"; L_PRESS_ANY="[Press any key]"; L_NAVIGATE="[↑↓] Navigate [Enter] Ok [q] Back"
    fi
}

save_paths() {
    cat > "$PATHS_FILE" << EOF
AUTOS_DIR="$AUTOS_DIR"
DOCS_DIR="$DOCS_DIR"
EOF
}
