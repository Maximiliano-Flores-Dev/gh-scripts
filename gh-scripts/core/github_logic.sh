#!/bin/bash
# ===========================================================
# MODULE: GITHUB LOGIC (Auth & Repo)
# ===========================================================

get_gh_user() {
    local u; u=$(gh api user --jq '.login' 2>/dev/null)
    [ -z "$u" ] && u=$(gh auth status 2>&1 | grep -i "logged in" | sed -E 's/.*account ([^ ]+).*/\1/' | head -1)
    echo "$u"
}

manage_gh_auth() {
    local user; user=$(get_gh_user)
    if [ -n "$user" ]; then
        echo -e "  ${TEXTO_VERDE}✅ $L_LOGGED_AS: ${BOLD}@$user${RESET}\n"
        echo -ne "  Logout? $L_CONFIRM: "; read -r c
        [[ "$c" =~ ^[ysYS1sS]$ ]] && gh auth logout
    else
        echo -e "  \e[33m⚠ $L_NOT_LOGGED\e[0m\n"
        echo -ne "  Login? $L_CONFIRM: "; read -r c
        [[ "$c" =~ ^[ysYS1sS]$ ]] && gh auth login
    fi
}

manage_official_repo() {
    local repo_dir="$SCRIPT_DIR/.gh-scripts-repo"
    if [ -d "$repo_dir/.git" ]; then
        echo -e "  ${TEXTO_VERDE}🔄 Updating official repo...${RESET}"
        git -C "$repo_dir" pull
    else
        echo -e "  ${TEXTO_VERDE}📥 Cloning $OFFICIAL_REPO...${RESET}"
        git clone "$OFFICIAL_REPO" "$repo_dir"
    fi
    sleep 1
}
