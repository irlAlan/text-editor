run: build

build: ./tedit/
	odin build oedit -out:bin/oedit -o:speed -debug
