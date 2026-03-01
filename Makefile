SKILLS_DIR := $(HOME)/.claude/skills
SKILLS := $(patsubst %/SKILL.md,%,$(wildcard */SKILL.md))

.PHONY: install uninstall list help

help:
	@echo "Targets:"
	@echo "  install   - symlink all skills to ~/.claude/skills/"
	@echo "  uninstall - remove symlinks from ~/.claude/skills/"
	@echo "  list      - show skills and their install status"

install: $(SKILLS_DIR)
	@for skill in $(SKILLS); do \
		target=$(SKILLS_DIR)/$$skill; \
		if [ -L $$target ]; then \
			echo "  skip  $$skill (already linked)"; \
		else \
			ln -s $(CURDIR)/$$skill $$target && echo "  link  $$skill"; \
		fi \
	done

uninstall:
	@for skill in $(SKILLS); do \
		target=$(SKILLS_DIR)/$$skill; \
		if [ -L $$target ]; then \
			rm $$target && echo "  unlinked  $$skill"; \
		fi \
	done

list:
	@for skill in $(SKILLS); do \
		target=$(SKILLS_DIR)/$$skill; \
		if [ -L $$target ]; then \
			echo "  [x] $$skill"; \
		else \
			echo "  [ ] $$skill"; \
		fi \
	done

$(SKILLS_DIR):
	mkdir -p $@
