#!/usr/bin/env bash
set -euo pipefail

# === Model/profile names ===
SILENT='HP Victus 16-e0xxx Silent'
BALANCED='HP Victus 16-e0xxx Balanced'
STOCK='HP Victus 16-e0xxx'
SMOOTH='HP Victus 16-e0xxx Smooth'
PERFORMANCE='HP Victus 16-e0xxx Performance'
SMOOTH_D2='HP Victus 16-e0xxx Smooth Disabled2'
PERFORMANCE_D2='HP Victus 16-e0xxx Performance Disabled2'
SMOOTH_F2C='HP Victus 16-e0xxx Smooth Fan2-35'
PERF_F2C='HP Victus 16-e0xxx Performance Fan2-40'
SMOOTH_F2C60='HP Victus 16-e0xxx Smooth Fan2-60'
SMOOTH_F2C100='HP Victus 16-e0xxx Smooth Fan2-100'

need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing: $1"; exit 1; }; }
need nbfc

# Get current profile from nbfc
current_cfg() {
  nbfc status 2>/dev/null | awk -F':' '/Selected Config Name/{gsub(/^[ \t]+/,"",$2); print $2}'
}

show_current_mode() {
  echo " Current mode: $(current_cfg || echo 'unknown')"
}

switch_profile() {
  local name="$1"
  echo "Switching to: $name ..."
  sudo nbfc config --set "$name"
  sudo nbfc restart
  nbfc set --auto
  echo "Active profile: $name"
  show_current_mode
}

switch_manual_speed() {
  local speed="$1"
  echo "Setting manual fan speed to $speed% ..."
  sudo nbfc config --set "$STOCK"
  sudo nbfc restart
  nbfc set -s "$speed"
  echo "Fans set to $speed%"
  show_current_mode
}

fan_status() {
  show_current_mode
  echo "--------------- NBFC STATUS ---------------"
  nbfc status | sed -n '1,20p'
  echo "-------------------------------------------"
}

fan_status_live() {
  echo "Press Ctrl+C to exit live fan status..."
  while true; do
    # redraw screen without nuking scrollback
    tput clear 2>/dev/null || clear
    echo " Current mode: $(current_cfg || echo 'unknown')"
    echo "--------------- NBFC STATUS ---------------"
    nbfc status | sed -n '1,20p'
    echo "-------------------------------------------"
    sleep 1
  done
}



enable_boot()   { sudo systemctl enable nbfc_service && echo "Enabled nbfc on boot"; show_current_mode; }
disable_boot()  { sudo systemctl disable nbfc_service && echo "Disabled nbfc on boot"; show_current_mode; }

manual_auto() { nbfc set --auto && echo "Fan control: AUTO (profile curve)"; show_current_mode; }

# --- Menu loop ---
while true; do
  echo
  echo "====== Fan Controller (nbfc) ======"
  show_current_mode
  cat <<MENU
1)  Fan status (single snapshot)
2)  Switch to STOCK
3)  Switch to SILENT
4)  Switch to BALANCED
5)  Switch to SMOOTH           (anti-hunt, 20% min, Fan2 active)
6)  Switch to PERFORMANCE      (aggressive, 30% min, Fan2 active)
7)  Switch to SMOOTH-D2        (anti-hunt, Fan2 DISABLED)
8)  Switch to PERFORMANCE-D2   (aggressive, Fan2 DISABLED)
9)  Switch to SMOOTH-F2C       (Fan1 temp-regulated, Fan2 constant 35%)
10) Switch to PERF-F2C         (Fan1 aggressive, Fan2 constant 40%)
17) Switch to SMOOTH-F2C60     (Fan1 temp-regulated, Fan2 constant 60%)
18) Switch to SMOOTH-F2C100    (Fan1 temp-regulated, Fan2 constant 100% - worn bearing fix)
11) BLAST (100% manual)
12) QUIET30 (30% manual)
13) Back to AUTO (use profile)
14) Enable nbfc on boot
15) Disable nbfc on boot
16) Fan status LIVE (updates every second)
0)  Quit
MENU
  read -rp "Choose: " c
  case "${c:-}" in
    1)  fan_status ;;
    2)  switch_profile "$STOCK" ;;
    3)  switch_profile "$SILENT" ;;
    4)  switch_profile "$BALANCED" ;;
    5)  switch_profile "$SMOOTH" ;;
    6)  switch_profile "$PERFORMANCE" ;;
    7)  switch_profile "$SMOOTH_D2" ;;
    8)  switch_profile "$PERFORMANCE_D2" ;;
    9)  switch_profile "$SMOOTH_F2C" ;;
    10) switch_profile "$PERF_F2C" ;;
    17) switch_profile "$SMOOTH_F2C60" ;;
    18) switch_profile "$SMOOTH_F2C100" ;;
    11) switch_manual_speed 100 ;;
    12) switch_manual_speed 30 ;;
    13) manual_auto ;;
    14) enable_boot ;;
    15) disable_boot ;;
    16) fan_status_live ;;
    0)  echo "Bye!"; exit 0 ;;
    *)  echo "Invalid choice";;
  esac
done



######### For for få utregning fra prosent to rpm kjører man et loop


#neov@matrixv:~$ for p in 10 12 15 18 20 22 25 28 30 32 35 38; do
#  nbfc set -s "$p"
#  sleep 2
#  printf "%s -> " "$p"
#  nbfc status | awk -F':' '/Current Fan Speed/{gsub(/^[ \t]+/,"",$2); print $2"%"}' | head -n1
#done
#nbfc set --auto
#10 -> 6.25%
#12 -> 6.25%
#15 -> 15.62%
#18 -> 9.38%
#20 -> 9.38%
#22 -> 9.38%
#25 -> 12.50%
#28 -> 12.50%
#30 -> 15.62%
#32 -> 15.62%
#35 -> 15.62%
#38 -> 18.75%
#neov@matrixv:~$ for p in 40 42 44 46 48 50 52 54 56 58 60 62; do
#  nbfc set -s "$p"; sleep 2
#  printf "%2s%% -> " "$p"
#  nbfc status | awk -F':' '/Current Fan Speed/{gsub(/^[ \t]+/,"",$2); print $2"%"; exit}'
#done
#nbfc set --auto
#40% -> 25.00%
#42% -> 21.88%
#44% -> 21.88%
#46% -> 25.00%
#48% -> 25.00%
#50% -> 28.12%
#52% -> 28.12%
#54% -> 28.12%
#56% -> 31.25%
#58% -> 31.25%
#60% -> 31.25%
#62% -> 34.38%
#neov@matrixv:~$

############# For gjør endriing på profilene på min egen pc (Skal være noe ligende for andre også (defualt fra repo)

#neov@matrixv:~$
#(Perfekt spot for noe : Fan1 56 56 and Fan2 15 15  Faulty fan 2 (maybe)

#root@matrixv:/home/neov# cd /usr/share/nbfc/configs/
#root@matrixv:/usr/share/nbfc/configs#

#nano "HP Victus 16-e0xxx Balanced.json"
#sudo nbfc config --set "HP Victus 16-e0xxx Balanced"
#sudo nbfc restart
