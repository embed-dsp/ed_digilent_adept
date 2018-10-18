#!/bin/sh

# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This shell script returns the system name.
#
# Usage:
#   get_system.sh

system=$(uname -s)

# Normalize system names.
case $system in
    Linux*)
        system=linux
        ;;
    CYGWIN*)
        system=cygwin
        ;;
    MINGW32*)
        system=mingw32
        ;;
    MINGW64*)
        system=mingw64
        ;;
    *)
        echo "* ERROR *: Unknown system: $system"
        exit 1
esac

echo $system
