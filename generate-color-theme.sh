#!/bin/sh

RED='\033[1;31m'
BLUE='\033[1;36m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
UNDERLINE='\033[3;4m'
RESET='\033[0m'

printf $BLUE
printf '___________.__          __    __________               .__         \n'
printf '\_   _____/|  | _____ _/  |_  \______   \ ____   _____ |__|__  ___ \n'
printf ' |    __)  |  | \__  \\   __\  |       _// __ \ /     \|  \  \/  / \n'
printf ' |     \   |  |__/ __ \|  |    |    |   \  ___/|  Y Y  \  |>    <  \n'
printf ' \___  /   |____(____  /__|    |____|_  /\___  >__|_|  /__/__/\_ \ \n'
printf '     \/              \/               \/     \/      \/         \/ \n'
printf $RESET

if [ $# -lt 3 ]
then
  printf "    ${GREEN}Usage:${RESET} ${UNDERLINE}$0${RESET} ${ORANGE}<VARIANT_NAME> <HIGHLIGHT_HEX_COLOR> <HIGHLIGHT_TEXT_HEX_COLOR>${RESET}\n"
  printf "                                                                                                                                  \n"
  printf "        ${GREEN}Example:${RESET} ${UNDERLINE}$0${RESET} ${ORANGE}FOOBAR '#123456' '#987654'${RESET}                               \n"
fi

command -v make > /dev/null \
  || { printf "   ${RED} !! YOU NEED TO INSTALL ${RESET}make\n"; EXIT=1; }
command -v inkscape > /dev/null \
  || { printf "   ${RED} !! YOU NEED TO INSTALL ${RESET}inkscape\n"; EXIT=1; }
command -v sassc > /dev/null \
  || { printf "   ${RED} !! YOU NEED TO INSTALL ${RESET}sassc\n"; EXIT=1; }

command -v optipng > /dev/null \
  || printf "   ${ORANGE} !! OPTIONALLY INSTALL optipng for assets minification${RESET}"

[ -z $EXIT ] || exit 1


eval export COLOR_VARIANTS="${1:-Nice}"
eval export COLOR_$COLOR_VARIANTS="${2:-#2c3300}"
eval export TEXT_COLOR_$COLOR_VARIANTS="${3:-#f2f2f2}"

rm -rf themes/*
make -j build
