#!/bin/bash

function cecho() {
    echo -e "\033[38;5;214m$@\033[0m"
}

# Memory tuning for UHD
sysctl -w net.core.wmem_max=2500000

# Disable IPv6 to speed up mDNS resolution
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.conf.lo.disable_ipv6=1

# Show the PATH
cecho "PATH = ${PATH}"

# never exit
while true; do sleep 10000; done
