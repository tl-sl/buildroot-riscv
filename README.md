# Buildroot RISC-V Toolchain Builder

## Usage
```sh
git submodule update --init
cd buildroot
git am ../patches/0001-arch-riscv-add-xthead-extension-option.patch
cd..

make riscv
```

You can run any buildroot commands with
```sh
make br <cmd>
make br menuconfig
