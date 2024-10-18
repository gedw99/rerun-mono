DEP_ROOT_NAME=.dep
DEP_ROOT=$(PWD)/$(DEP_ROOT_NAME)

export PATH:=$(DEP_ROOT):$(PATH)


print:
	@echo ""

all: src

clean:
	# save space :)
	rm -rf $(DEP_ROOT)

WGOT_BIN=wgot
WHICH_BIN=gowhich

dep:
	mkdir -p $(DEP_ROOT)
	echo $(DEP_ROOT_NAME) >> .gitignore

	go install github.com/bitrise-io/got/cmd/wgot@latest
	mv $(GOPATH)/bin/$(WGOT_BIN) $(DEP_ROOT)/$(WGOT_BIN)

	go install github.com/hairyhenderson/go-which/cmd/which@latest
	mv $(GOPATH)/bin/which $(DEP_ROOT)/$(WHICH_BIN)


RERUN_CLI_BIN=rerun-cli
DUCKDB_BIN=duckdb

src: dep src-cli src-duck
src-cli: dep
	# CLI
	# https://github.com/rerun-io/rerun/blob/main/crates/top/rerun-cli/README.md
	# https://github.com/rerun-io/rerun/releases/tag/0.19.0
	$(WGOT_BIN) -o $(DEP_ROOT)/$(RERUN_CLI_BIN) https://github.com/rerun-io/rerun/releases/download/0.19.0/rerun-cli-0.19.0-x86_64-apple-darwin
	chmod +x $(DEP_ROOT)/$(RERUN_CLI_BIN)
src-duck: dep
	# Duckdb
	# https://duckdb.org/#quickinstall
	# https://github.com/duckdb/duckdb/releases/tag/v1.1.2
	$(WGOT_BIN) -o $(DEP_ROOT)/duck.zip https://github.com/duckdb/duckdb/releases/download/v1.1.2/duckdb_cli-osx-universal.zip
	chmod +x $(DEP_ROOT)/duck.zip
	cd $(DEP_ROOT) && unzip duck.zip

	# Grafana also uses DuckDB



cli-h:
	$(RERUN_CLI_BIN) -h
cli-run:
	# SDK Server 0.0.0.0:9876
	$(RERUN_CLI_BIN)

duck-h:
	$(DUCKDB_BIN) -help
duck-run:
	$(DUCKDB_BIN)



