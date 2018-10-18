#!/bin/sh

# Copyright (c) 2018 embed-dsp
# All Rights Reserved

# $Author:   Gudmundur Bogason <gb@embed-dsp.com> $
# $Date:     $
# $Revision: $

# This shell script returns the machine name.
#
# Usage:
#   get_machine.sh

machine=$(uname -m)

# Unify Intel/AMD machine names.
case $machine in
    i386 | i486 | i586 | i686 | i786 | athlon)
        machine="x86"
        ;;
    x86_64 | amd64)
        machine="x86_64"
        ;;
esac

echo $machine
