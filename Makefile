ZIP_ROOT := nuke-oil
ZIP_NAME := $(ZIP_ROOT)_$(VERSION).zip
STAGE_DIR := .zip_stage

.PHONY: all clean check-version

all: check-version $(ZIP_NAME)

check-version:
	@if [ -z "$(VERSION)" ]; then \
		echo "ERROR: VERSION is not set. Use: VERSION=x.y.z make"; \
		exit 1; \
	fi

$(ZIP_NAME):
	@echo "Staging files…"
	@rm -rf $(STAGE_DIR)
	@mkdir -p $(STAGE_DIR)/$(ZIP_ROOT)

	@# Copy everything except .git and Makefile
	@tar cf - \
		--exclude=./.claude \
		--exclude=./CLAUDE.md \
		--exclude=./.git \
		--exclude=./Makefile \
		--exclude=./.gitignore \
		--exclude=./*zip \
		--exclude=./$(STAGE_DIR) \
		--exclude=./$(ZIP_NAME) \
		. \
	| tar xf - -C $(STAGE_DIR)/$(ZIP_ROOT)

	@echo "Creating $(ZIP_NAME)…"
	@cd $(STAGE_DIR) && zip -r ../$(ZIP_NAME) $(ZIP_ROOT)

	@rm -rf $(STAGE_DIR)
	@echo "Done."

clean:
	rm -rf $(STAGE_DIR) $(ZIP_NAME)

