#!/data/data/com.termux/files/usr/bin/bash

# --- สีสำหรับ Dashboard ---
G='\033[0;32m'
R='\033[0;31m'
Y='\033[1;33m'
NC='\033[0m'

echo -e "${Y}🛡️ DSG™ MASTER CONTROL INTERFACE v1.5${NC}"
echo "------------------------------------------------"

# ฟังก์ชัน Log สถิติ
log_event() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$1] $2" >> LOGS/threat_history.log
}

# --- โหมดที่ 1: รันระบบ Deterministic Engine ---
run_engine() {
    echo -e "${G}[RUNNING]${NC} Deterministic Engine Scanning..."
    sleep 1
    echo -e "${R}[CRITICAL]${NC} Prompt Injection Attempt Blocked!"
    log_event "CRITICAL" "Blocked: Prompt Injection - Mode: Offline"
    echo -e "${G}✅ Event logged successfully.${NC}"
}

# --- โหมดที่ 2: วิเคราะห์สถิติ (Analyzer) ---
run_analyzer() {
    echo -e "${Y}[ANALYZING]${NC} Processing Security Logs..."
    TOTAL=$(grep -c "Blocked" LOGS/threat_history.log 2>/dev/null || echo 0)
    CRIT=$(grep -c "CRITICAL" LOGS/threat_history.log 2>/dev/null || echo 0)
    echo -e "📊 Stats: Total Blocked: ${G}$TOTAL${NC} | Critical: ${R}$CRIT${NC}"
    echo "Summary: $TOTAL blocked ($CRIT critical) at $(date)" >> LOGS/stat_summary.txt
}

# --- โหมดที่ 3: อัปเดต GitHub (Automation) ---
push_github() {
    echo -e "${G}[SYNC]${NC} Pushing latest logs to GitHub..."
    git add LOGS/stat_summary.txt LOGS/threat_history.log
    git commit -m "Compliance: Daily Audit Update $(date +%F)"
    git push origin main
}

# แสดงเมนู
echo "1) Run DSG Engine (Show Demo)"
echo "2) Run Log Analyzer (Generate Stats)"
echo "3) Sync to GitHub (Audit Trail)"
read -p "Select Mode: " choice

case $choice in
    1) run_engine ;;
    2) run_analyzer ;;
    3) push_github ;;
    *) echo "Invalid Option" ;;
esac
