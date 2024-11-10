alias r := run
alias b := build
alias t := test

run:
    odin run . -target:darwin_amd64

build: 
    odin run . -target:darwin_amd64

test: 
    odin test . -target:darwin_amd64
