run: build

build: ./oedit/
	odin build oedit -out:bin/oedit -o:speed -debug
