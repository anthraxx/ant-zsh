RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
BOLD=$(shell tput bold)
RST=$(shell tput sgr0)

INIT_ZSH=ant-zsh.zsh

.PHONY: all submodule test test-zshrc test-source test-env-var install install-zshrc install-zshenv

all: submodule

test: test-zshrc test-source test-env-var

test-zshrc:
	@if test ! -e "$(HOME)/.zshrc" ; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(HOME)/.zshrc$(RST) not found"; \
		echo "    $(BOLD)^^^ fix: $(RST)run $(BOLD)make install-zshrc$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found $(HOME)/.zshrc$(RST)"

test-source:
	@if test -z "$(shell grep 'source $$ZSH/$(INIT_ZSH)' $(HOME)/.zshrc)" ; then \
		echo "$(BOLD)$(RED)[-] $(RST)missing $(BOLD)$(INIT_ZSH)$(RST) include in $(BOLD)$(HOME)/.zshrc$(RST)"; \
		echo "    $(BOLD)^^^ fix: $(RST)add >> $(BOLD)source \$$ZSH/$(INIT_ZSH)$(RST) << in your $(BOLD).zshrc$(RST)"; \
		echo "    $(BOLD)^^^  or: $(RST)remove your $(BOLD).zshrc$(RST) and run $(BOLD)make install-zshrc$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found $(INIT_ZSH) include$(RST)"

test-env-var:
	@if test ! -e "$(shell zsh -c 'echo $$ZSH')" ; then \
		echo "$(BOLD)$(RED)[-] $(RST)missing $(BOLD)\$$ZSH$(RST) env var$(RST)"; \
		echo "    $(BOLD)^^^ fix: $(RST)add >> $(BOLD)export ZSH=$(shell pwd)$(RST) << in your $(BOLD).zshenv$(RST)"; \
		echo "    $(BOLD)^^^  or: $(RST)remove your $(BOLD).zshenv$(RST) and run $(BOLD)make install-zshenv$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found \$$ZSH at $(shell zsh -c 'echo $$ZSH')$(RST)"

install: install-zshrc install-zshenv

install-zshrc:
	@if test -e "$(HOME)/.zshrc" ; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(HOME)/.zshrc$(RST) already exists"; \
		echo "    $(BOLD)^^^$(RST) remove or backup manually before overwriting!$(RST)"; \
		exit 1; \
	fi
	@cp template/zshrc.zsh-template $(HOME)/.zshrc
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)installed default $(HOME)/.zshrc$(RST)"

install-zshenv:
	@if test -e "$(HOME)/.zshenv" ; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(HOME)/.zshenv$(RST) already exists"; \
		echo "    $(BOLD)^^^$(RST) remove or backup manually before overwriting!$(RST)"; \
		exit 1; \
	fi
	@cp template/zshenv.zsh-template $(HOME)/.zshenv
	@echo 'ZSH=$(shell pwd)' >> $(HOME)/.zshenv
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)installed default $(HOME)/.zshenv$(RST)"

submodule: 
	@git submodule init
	@git submodule update
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)initialized submodules$(RST)"
