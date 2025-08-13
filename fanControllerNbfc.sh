#!/usr/bin/env bash
set -euo pipefail

# === Model/profile names ===
SILENT='HP Victus 16-e0xxx Silent'
BALANCED='HP Victus 16-e0xxx Balanced'
STOCK='HP Victus 16-e0xxx'

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
1) Fan status (single snapshot)
2) Switch to STOCK
3) Switch to SILENT
4) Switch to BALANCED
5) BLAST (100% manual)
6) QUIET30 (30% manual)
7) Back to AUTO (use profile)
8) Enable nbfc on boot
9) Disable nbfc on boot
11) Fan status LIVE (updates every second)
0) Quit
MENU
  read -rp "Choose: " c
  case "${c:-}" in
    1) fan_status ;;
    2) switch_profile "$STOCK" ;;
    3) switch_profile "$SILENT" ;;
    4) switch_profile "$BALANCED" ;;
    5) switch_manual_speed 100 ;;
    6) switch_manual_speed 30 ;;
    7) manual_auto ;;
    8) enable_boot ;;
    9) disable_boot ;;
    11) fan_status_live ;;
    0) echo "Bye!"; exit 0 ;;
    *) echo "Invalid choice";;
  esac
done
