#!/bin/sh

# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This shell script returns the architecture name, i.e. the combination of 
# kernel name and machine name.
# 
# Examples:
#   linux_armv6l         Linux, 32-bit ARMV6 Little-Endian (Raspberry Pi Zero W, ...)
#   linux_armv7l         Linux, 32-bit ARMV7 Little-Endian (Raspberry Pi 3 B/B+, ...)
#   linux_x86            Linux, 32-bit Intel compatible
#   linux_x86_64         Linux, 64-bit Intel compatible
#   cygwin_x86          Cygwin, 32-bit Intel compatible
#   cygwin_86_64        Cygwin, 64-bit Intel compatible
#
# Usage:
#   get_arch.sh         Return architecture name.
#   get_arch.sh 32      Return architecture name, assuming a 32-bit machine.
#   get_arch.sh 64      Return architecture name, assuming a 64-bit machine.

kernel=$(uname -s)
machine=$(uname -m)

# kernel="Linux"
# kernel="CYGWIN_NT-10.0-WOW"
# kernel="CYGWIN_NT-10.0"
# kernel="Fubar"

# machine="i386"
# machine="i686"
# machine="x86_64"
# machine="amd64"
# machine="armv6l"
# machine="armv7l"

# Unify Intel/AMD machine names.
case $machine in
    i386 | i686)
        if [ "$1" == "64" ]; then
            echo "* ERROR *: 64-bit not supported: $machine"
            exit 1
        else
            machine="x86"
        fi
        ;;
    x86_64 | amd64)
        if [ "$1" == "32" ]; then
            machine="x86"
        else
            machine="x86_64"
        fi
        ;;
esac

# Normalize kernel names.
case $kernel in
    Linux*)
        kernel=linux
        ;;
    CYGWIN*)
        kernel=cygwin
        ;;
    *)
        echo "* ERROR *: Unknown kernel: $kernel"
        exit 1
esac

arch="$kernel"_"$machine"
echo $arch
