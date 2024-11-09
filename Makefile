# ifeq ($(origin .RECIPEPREFIX), undefined)
#   $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
# endif
# .RECIPEPREFIX = >

SHELL := zsh

run:
	gcc -c library.c
	odin run . -target:darwin_arm64
