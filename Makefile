run: build
	./bin/sodit

build: ./sodit/
	odin build sodit -out:bin/sodit -o:speed -debug
