all: run

build:
	docker build --tag tnishinaga/aarch64-elf_toolchain $(dir $(firstword $(MAKEFILE_LIST)))

run:
	docker run -it --rm -v ${PWD}:/home/work:rw tnishinaga/aarch64-elf_toolchain /bin/bash