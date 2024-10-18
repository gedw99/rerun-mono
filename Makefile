DEP_ROOT_NAME=.dep
DEP_ROOT=$(PWD)/$(DEP_ROOT_NAME)

export PATH:=$(DEP_ROOT):$(PATH)

print:

dep:
	mkdir -p $(DEP_ROOT)
	echo $(DEP_ROOT_NAME) >> .gitignore

	go install github.com/bitrise-io/got/cmd/wgot@latest
	mv $(GOPATH)/bin/wgot $(DEP_ROOT)/wgot

src:
	wgot -o  https://github.com/rerun-io/rerun/releases/download/0.19.0/rerun-cli-0.19.0-x86_64-apple-darwin

