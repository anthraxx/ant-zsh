.PHONY: all submodule
all: submodule

submodule: 
	git submodule init
	git submodule update
