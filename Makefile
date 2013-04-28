RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
BOLD=$(shell tput bold)
RST=$(shell tput sgr0)

INIT_ZSH=ant-zsh.zsh

.PHONY: all submodule test test-zshrc test-source install

all: submodule

test: test-zshrc test-source

test-zshrc:
	@if test ! -e "$(HOME)/.zshrc" ; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(HOME)/.zshrc$(RST) not found"; \
		echo "    $(BOLD)^^^$(RST) run $(BOLD)make install$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found $(HOME)/.zshrc$(RST)"

test-source:
	@if test -z "$(shell grep 'source $$ZSH/$(INIT_ZSH)' $(HOME)/.zshrc)" ; then \
		echo "$(BOLD)$(RED)[-] $(RST)missing $(BOLD)$(INIT_ZSH)$(RST) include in $(BOLD)$(HOME)/.zshrc$(RST)"; \
		echo "    $(BOLD)^^^ fix: $(RST)add >> $(BOLD)source \$$ZSH/$(INIT_ZSH)$(RST) << in your $(BOLD).zshrc$(RST)"; \
		echo "    $(BOLD)^^^  or: $(RST)remove your $(BOLD).zshrc$(RST) and run $(BOLD)make install$(RST)"; \
		exit 1; \
	fi
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)found $(INIT_ZSH) include$(RST)"

install:
	@if test -e "$(HOME)/.zshrc" ; then \
		echo "$(BOLD)$(RED)[-] $(RST)$(BOLD)$(HOME)/.zshrc$(RST) already exists"; \
		echo "    $(BOLD)^^^$(RST) remove or backup manually before overwriting!$(RST)"; \
		exit 1; \
	fi
	@cp template/zshrc.zsh-template $(HOME)/.zshrc
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)installed default $(HOME)/.zshrc$(RST)"

submodule: 
	@git submodule init
	@git submodule update
	@echo "$(BOLD)$(GREEN)[+] $(RST)$(BOLD)initialized submodules$(RST)"
