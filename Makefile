SOURCE = src/
BUILD = build/
TEMPLATE = .t
TEMPLATE_TARGETS = $(addprefix $(BUILD),$(subst $(TEMPLATE),,$(shell ls $(SOURCE) | grep -E \\.t$)))
COPY_TARGETS = $(addprefix $(BUILD),$(shell ls $(SOURCE) | grep -v -E \\.t$))

usage:
	@echo $(TEMPLATE_TARGETS)
	@echo $(COPY_TARGETS)
	@echo "Run 'make install' to build and overwrite any existing files in ~, or 'sudo make system-install' to add system-wide configurations."

$(TEMPLATE_TARGETS): $(BUILD)%: $(SOURCE)%$(TEMPLATE)
	python3 -m template.compile $< > $@

$(COPY_TARGETS): $(BUILD)%: $(SOURCE)%
	cp $< $@

clean:
	rm $(BUILD)*

build: $(TEMPLATE_TARGETS) $(COPY_TARGETS)

install: build
	install -m 640 build/vimrc ~/.vimrc
	install -m 640 build/bashrc ~/.bashrc

.PHONY: usage build install clean
