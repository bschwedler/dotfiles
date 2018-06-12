.PHONY: all
all: bin dotfiles etc ## Installs the bin directory files and the dotfiles.

.PHONY: bin
bin: ## Installs the bin directory files.
	mkdir -p $(HOME)/local/bin
	# add aliases for things in bin
	for file in $(shell find $(CURDIR)/bin -type f -not -name "*-backlight" -not -name ".*.swp"); do \
		f=$$(basename $$file); \
		ln -sf $$file $(HOME)/local/bin/$$f; \
	done

.PHONY: dotfiles
dotfiles: ## Installs the dotfiles.
	# add aliases for dotfiles
	for file in $(shell find $(CURDIR) -name ".*" -not -name ".gitignore" -not -name ".travis.yml" -not -name ".git"  -not -iwholename "$(CURDIR)/utils/*" -not -name ".*.swp" -not -name ".gnupg"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/$$f; \
	done; \
	# add files stored in ~/.config/
	for file in $(shell find $(CURDIR)/.config); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(HOME)/.config/$$f; \
	done; \
	ln -fn $(CURDIR)/gitignore $(HOME)/.gitignore;
	# If username and email are in.gitconfig, uncoment.
	# Uses ~/.gitlocal by default
	# git update-index --skip-worktree $(CURDIR)/.gitconfig;
	ln -snf $(CURDIR)/.fonts $(HOME)/.local/share/fonts;
	uname | grep -i Linux && ln -sfn $(CURDIR)/conf/vscode_settings.json $(HOME)/.config/Code/User/settings.json || true;
	uname | grep -i Darwin && ln -sfn $(CURDIR)/conf/vscode_settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json || true;
	uname | grep -i Darwin && ln -sfn $(CURDIR)/conf/vscode_settings.json $(HOME)/Library/Application\ Support/Code\ -\ Insiders/User/settings.json || true;

.PHONY: update
update: ## Updates all plugins
		git submodule update --init --recursive
		git submodule foreach git pull --recurse-submodules origin master

.PHONY: etc
etc: ## Installs the etc directory files
	mkdir -p $(HOME)/local/etc
	ln -fsn $(CURDIR)/utils/liquidprompt/liquidprompt $(HOME)/local/etc/liquidprompt

.PHONY: test
test: shellcheck ## Runs all the tests on the files in the repository.

# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

.PHONY: shellcheck
shellcheck: ## Runs the shellcheck tests on the scripts.
	docker run --rm -i $(DOCKER_FLAGS) \
		--name df-shellcheck \
		-v $(CURDIR):/usr/src:ro \
		--workdir /usr/src \
		r.j3ss.co/shellcheck ./test.sh

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
