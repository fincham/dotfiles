SOURCE = src/
BUILD = build/
TEMPLATE = .t
TEMPLATE_TARGETS = $(addprefix $(BUILD),$(subst $(TEMPLATE),,$(shell ls $(SOURCE) | grep -E \\.t$)))
COPY_TARGETS = $(addprefix $(BUILD),$(shell ls $(SOURCE) | grep -v -E \\.t$))

usage:
	@echo "Run 'make install' to build and overwrite any existing files in ~, or 'sudo make system-install' to add system-wide configurations."

$(TEMPLATE_TARGETS): $(BUILD)%: $(SOURCE)%$(TEMPLATE)
	python3 -m template.compile $< > $@

$(COPY_TARGETS): $(BUILD)%: $(SOURCE)%
	cp $< $@

clean:
	rm $(BUILD)*

build: $(TEMPLATE_TARGETS) $(COPY_TARGETS)

install: build
	install -m 750 -d ~/.local/bin

	install -m 640 build/vimrc ~/.vimrc
	install -m 640 build/bashrc ~/.bashrc

	install -m 700 -d ~/.gnupg
	install -m 600 build/gpg-agent ~/.gnupg/gpg-agent.conf
	install -m 600 build/gpg ~/.gnupg/gpg.conf
	
	install -m 700 -d ~/.ssh
	install -m 640 build/ssh ~/.ssh/config

	install -m 640 build/tmux ~/.tmux.conf

.PHONY: usage build install clean
