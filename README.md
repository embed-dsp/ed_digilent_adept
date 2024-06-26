
# Install of Digilent Adept 2 Runtime and Utilities

This repository contains make file for easy install of the 
[Digilent Adept 2](https://digilent.com/reference/software/adept/start) Runtime and Utilities.

The Adept Runtime consists of the shared libraries, firmware images, and
configuration files necessary to communicate with Digilent's devices.

Adept Utilities is a set of command line applications that can be used in
conjunction with the Adept Runtime to manage and communicate with
Digilent's devices.

Currently Adept Utilities consists of three applications: Digilent Adept
Utility (**dadutil**), Digilent JTAG Config Utility (**djtgcfg**), and Digilent
NetFPGA-SUME Flash Configuration Utility (**dsumecfg**).
* The Adept Utility (**dadutil**) provides a command line interface for discovering 
  Digilent devices, querying device information, manipulating the device table, 
  and setting  device information. 
* The JTAG Config Utility (**djtgcfg**) allows users to initialize, program, and 
  erase FPGAs  and CPLDs on Digilent boards using a command line interface.
* The NetFPGA-SUME Flash Configuration Utility (**dsumecfg**) allows users to
  write bit or bin files to a specific section of the flash memory on
  Digilent's NetFPGA-SUME.


# Get Source Code

## ed_digilent_adept
Get the code for this component to a local directory on your PC.

```bash
git clone https://github.com/embed-dsp/ed_digilent_adept.git
```

## Digilent Adept 2

Open Web Browser and download the [Digilent Adept 2](https://digilent.com/reference/software/adept/start) Runtime and Utilities (ZIP files)
and store in the `ed_digilent_adept/src` directory.

Enter the ed_digilent_adept directory.
```bash
cd ed_digilent_adept
```

Edit the **Makefile** for selecting the Runtime version and the Utilities version.
```bash
# Edit Makefile ...
vim Makefile

RUNTIME_VERSION = 2.27.9
UTILITIES_VERSION = 2.7.1
```


# Build

```bash
# Unpack source code into build/ directory.
make prepare
```


# Install

```bash
# Install build products.
sudo make install
```

The build products are installed in the following locations:

```bash
/opt/
└── digilent/
    ├── linux_x86_64/       # 64-bit binaries and libraries for Linux
    │   ├── bin/
    |   |   ├── dadutil     # Digilent Adept Utility
    |   |   ├── djtgcfg     # Digilent JTAG Config Utility
    |   |   └── dsumecfg    # Digilent NetFPGA-SUME Flash Configuration Utility
    │   ├── sbin/
    |   |   └── dftdrvdtch  # ... Runtime
    │   └── lib/
    │       ...
    └── share/              # Architecture independent data files.
        ├── data/
        │   ...
        ├── dsumecfg/
        │   ...
        └── man/
            ...
```

```bash
/etc/
├── digilent-adept.conf
├── ld.so.conf.d/
│    ├── digilent-adept-libraries.conf
│    ...
├── udev/
│   ├── rules.d/
│       ├── 52-digilent-usb.rules
        ...
```


# Uninstall

```bash
# Uninstall build products.
sudo make uninstall
```
