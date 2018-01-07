
Install of Digilent Adept 2 Runtime and Utilities
=================================================

This repository contains make file for easy install of the [Digilent Adept 2](https://reference.digilentinc.com/reference/software/adept/start?redirect=1) Runtime and Utilities.

Get Source Code
===============

## ed_digilent_adept
```bash
git clone https://github.com/embed-dsp/ed_digilent_adept.git
```

## Digilent Adept 2
```bash
# Enter the ed_digilent_adept directory.
cd ed_digilent_adept

# Open Web Browser and download the Digilent Adept 2 Runtime and Utilities and store in the ed_digilent_adept directory.
https://reference.digilentinc.com/reference/software/adept/start?redirect=1

# Edit the Makefile for selecting the Runtime version.
vim Makefile
RUNTIME_VERSION = 2.16.6

# Edit the Makefile for selecting the Utilities version.
vim Makefile
UTILITIES_VERSION = 2.2.1
```

Build
=====
```bash
# Unpack 64-bit source code into build/ directory (Default: M=64)
make prepare
make prepare M=64

# Unpack 32-bit source code into build/ directory.
make prepare M=32
```

Install
=======
```bash
# Install 64-bit build products (Default: M=64)
sudo make install
sudo make install M=64

# Install 32-bit build products.
sudo make install M=32
```

The build products are installed in the following locations:
```bash
opt
└── digilent
    ├── linux_x86_64    # 64-bit binaries and libraries for Linux
    │   ├── bin
    │   │   ...
    │   ├── sbin
    │   │   ...
    │   └── lib
    │       ...
    ├── linux_x86       # 32-bit binaries and libraries for Linux
    │   ├── bin
    │   │   ...
    │   ├── sbin
    │   │   ...
    │   └── lib
    │       ...
    └── share           # Architecture independent data files.
        ├── data
        │   ...
        ├── dsumecfg
        │   ...
        └── man
            ...
```

Notes
=====

This has been testes with the following Linux distributions and compilers:
* `Fedora-27 (64-bit)` and `gcc-7.2.1`
