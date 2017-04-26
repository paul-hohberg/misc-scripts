#/bin/bash
divider===============================
divider=$divider$divider

#header="\n %-10s %8s %10s %11s\n"
header="\n %-10s %6s %11s %9s\n"
#format=" %-10s %08d %10s %11.2f\n"
format=" %-10s %08d %10s %11.2f"

width=43

printf "$header" "User" "Kernel" "Version"

printf "%$width.${width}s\n" "$divider"

#printf "$format" \
#Triangle 13  red 20 \
#Oval 204449 "dark blue" 65.656 \
#Square 3145 orange .7

printf "\n $(whoami)"
printf "%5s $(uname -s)"
printf "%4s $(uname -r)\n"