
# Copyright (c) 2018-2024 embed-dsp, All Rights Reserved.
# Author: Gudmundur Bogason <gb@embed-dsp.com>


# Runtime version.
RUNTIME_VERSION = 2.27.9

# Utilities version.
UTILITIES_VERSION = 2.7.1

# ==============================================================================

# Determine system.
SYSTEM = unknown
ifeq ($(findstring Linux, $(shell uname -s)), Linux)
	SYSTEM = linux
endif
# ifeq ($(findstring MINGW32, $(shell uname -s)), MINGW32)
# 	SYSTEM = mingw32
# endif
# ifeq ($(findstring MINGW64, $(shell uname -s)), MINGW64)
# 	SYSTEM = mingw64
# endif

# Determine machine.
MACHINE = $(shell uname -m)

# Architecture.
ARCH = $(SYSTEM)_$(MACHINE)

# ==============================================================================

# Build for 64-bit.
RUNTIME_PACKAGE = digilent.adept.runtime_$(RUNTIME_VERSION)-x86_64
RUNTIME_BINDIR = $(RUNTIME_PACKAGE)/bin64
RUNTIME_LIBDIR = $(RUNTIME_PACKAGE)/lib64
UTILITIES_PACKAGE = digilent.adept.utilities_$(UTILITIES_VERSION)-x86_64
UTILITIES_BINDIR = $(UTILITIES_PACKAGE)/bin64

# Installation directories.
PREFIX = /opt/digilent
EXEC_PREFIX = $(PREFIX)/$(ARCH)

DATADIR = $(PREFIX)/share
MANDIR = $(DATADIR)/man
MAN1DIR = $(MANDIR)/man1

BINDIR = $(EXEC_PREFIX)/bin
SBINDIR = $(EXEC_PREFIX)/sbin
LIBDIR = $(EXEC_PREFIX)/lib


all:
	@echo "ARCH        = $(ARCH)"
	@echo "PREFIX      = $(PREFIX)"
	@echo "EXEC_PREFIX = $(EXEC_PREFIX)"
	@echo ""
	@echo "## Build"
	@echo "make prepare"
	@echo ""
	@echo "## Install"
	@echo "sudo make install"
	@echo ""
	@echo "## Uninstall"
	@echo "sudo make uninstall"
	@echo ""
	@echo "## Cleanup"
	@echo "make clean"
	@echo ""


.PHONY: prepare
prepare:
	-mkdir build
	cd build && tar zxf ../src/$(RUNTIME_PACKAGE).tar.gz
	cd build && tar zxf ../src/$(UTILITIES_PACKAGE).tar.gz


.PHONY: install
install: install-runtime install-utilities
	# Update links and cache to the most recent shared libraries.
	/sbin/ldconfig

	# Reload udev rules.
	udevadm control --reload-rules


.PHONY: install-runtime
install-runtime:
	# Install system binaries.
	-mkdir -p $(SBINDIR)
	cp build/$(RUNTIME_BINDIR)/* $(SBINDIR)
	chmod 755 $(SBINDIR)/*

	# Install shared libraries.
	-mkdir -p $(LIBDIR)
	cp -d build/$(RUNTIME_LIBDIR)/* $(LIBDIR)
	chmod 755 $(LIBDIR)/*.so

	# Update and install dynamic loader configuration file.
	sed -e 's/\usr\/lib64.*/opt\/digilent\/linux_x86_64\/lib/' -e 's/\usr\/lib.*/opt\/digilent\/linux_x86\/lib/' build/$(RUNTIME_PACKAGE)/digilent-adept-libraries.conf > /etc/ld.so.conf.d/digilent-adept-libraries.conf
	chmod 644 /etc/ld.so.conf.d/digilent-adept-libraries.conf

	# Install firmware images and CoolRunner support files.
	-mkdir -p $(DATADIR)
	cp -r build/$(RUNTIME_PACKAGE)/data $(DATADIR)
	chmod 755 $(DATADIR)/data/firmware/*.so
	chmod 644 $(DATADIR)/data/firmware/*.HEX
	chmod 644 $(DATADIR)/data/firmware/*.img
	chmod 644 $(DATADIR)/data/xbr/*.map
	chmod 644 $(DATADIR)/data/xpla3/*.map
	chmod 644 $(DATADIR)/data/jtscdvclist.txt

	# Update and install configuration file.
	sed -e 's/DigilentPath=.*/DigilentPath=\/opt\/digilent\/share/' -e 's/DigilentDataPath=.*/DigilentDataPath=\/opt\/digilent\/share\/data/' build/$(RUNTIME_PACKAGE)/digilent-adept.conf > /etc/digilent-adept.conf
	chmod 644 /etc/digilent-adept.conf

	# Update and install udev rules.
	sed -e 's/\/usr/\/opt\/digilent\/$(ARCH)/' build/$(RUNTIME_PACKAGE)/52-digilent-usb.rules > /etc/udev/rules.d/52-digilent-usb.rules
	chmod 644 /etc/udev/rules.d/52-digilent-usb.rules


.PHONY: install-utilities
install-utilities:
	# Install utilities binaries.
	-mkdir -p $(BINDIR)
	cp build/$(UTILITIES_BINDIR)/* $(BINDIR)
	chmod 755 $(BINDIR)/*

	# Install utilities man pages.
	-mkdir -p $(MAN1DIR)
	cp build/$(UTILITIES_PACKAGE)/man/* $(MAN1DIR)
	chmod 644 $(MAN1DIR)/*

	# Install bitstream files.
	-mkdir -p $(DATADIR)/dsumecfg/bitstreams
	cp -r build/$(UTILITIES_PACKAGE)/bitstreams/dsumecfg/* $(DATADIR)/dsumecfg/bitstreams
	chmod 644 $(DATADIR)/dsumecfg/bitstreams/*


.PHONY: uninstall
uninstall: uninstall-runtime uninstall-utilities
	# Update links and cache to the most recent shared libraries.
	/sbin/ldconfig

	# Reload udev rules.
	udevadm control --reload-rules


.PHONY: uninstall-runtime
uninstall-runtime:
	-rm -f $(SBINDIR)/*
	-rm -f $(LIBDIR)/*

	-rm -f $(DATADIR)/data/firmware/*
	-rm -f $(DATADIR)/data/xbr/*
	-rm -f $(DATADIR)/data/xpla3/*
	-rm -f $(DATADIR)/data/jtscdvclist.txt

	-rm -f /etc/ld.so.conf.d/digilent-adept-libraries.conf
	-rm -f /etc/digilent-adept.conf
	-rm -f /etc/udev/rules.d/52-digilent-usb.rules


.PHONY: uninstall-utilities
uninstall-utilities:
	-rm -f $(BINDIR)/dadutil
	-rm -f $(BINDIR)/djtgcfg
	-rm -f $(BINDIR)/dsumecfg

	-rm -f $(MAN1DIR)/dadutil.1
	-rm -f $(MAN1DIR)/djtgcfg.1
	-rm -f $(MAN1DIR)/dsumecfg.1
	
	-rm -f $(DATADIR)/dsumecfg/bitstreams/*


.PHONY: clean
clean:
	-rm -rf build
