SOURCE = src/
BUILD = build/
TEMPLATE = .t
TEMPLATE_TARGETS = $(addprefix $(BUILD),$(subst $(TEMPLATE),,$(shell ls $(SOURCE) | grep -E \\.t$)))
COPY_TARGETS = $(addprefix $(BUILD),$(shell ls $(SOURCE) | grep -v -E \\.t$))

DEBIAN_PACKAGES = bash curl fzf rofi xdotool
MISSING_PACKAGES := $(strip $(foreach exec,$(DEBIAN_PACKAGES), $(if $(shell dpkg-query -W $(exec)),,$(exec))))

# utilities
usage:
	@echo "Run 'make install' to build and overwrite any existing files in ~, or 'sudo make perfect' to add system-wide configurations (Debian only, for now)."

$(TEMPLATE_TARGETS): $(BUILD)%: $(SOURCE)%$(TEMPLATE)
	python3 -m template.compile $< > $@

$(COPY_TARGETS): $(BUILD)%: $(SOURCE)%
	cp $< $@

# build stages
clean:
	rm $(BUILD)*

build: $(TEMPLATE_TARGETS) $(COPY_TARGETS)

dependencies: 
ifneq ($(MISSING_PACKAGES),)
	$(warning You had some missing packages ($(MISSING_PACKAGES)). On Debian you can use "sudo make install-packages" to install these.)
endif

install: build dependencies
	install -m 750 -d ~/.local/bin
	install -m 750 -d ~/.local/opt

	install -m 750 -d ~/.vim/colors
	install -m 640 build/vimrc ~/.vimrc
	install -m 640 build/sahara.vim ~/.vim/colors/sahara.vim

	install -m 640 build/bashrc ~/.bashrc
	install -m 640 build/profile ~/.profile

	install -m 700 -d ~/.gnupg
	install -m 600 build/gpg-agent ~/.gnupg/gpg-agent.conf
	install -m 600 build/gpg ~/.gnupg/gpg.conf
	
	install -m 700 -d ~/.ssh
	install -m 640 build/ssh ~/.ssh/config

	install -m 640 build/tmux ~/.tmux.conf

	# local tools
	install -m 750 build/emoji-menu ~/.local/bin/emoji-menu
	install -m 750 build/emoji-update ~/.local/bin/emoji-update
	install -m 750 build/fuzz ~/.local/bin/fuzz
	install -m 750 build/pass-menu ~/.local/bin/pass-menu
	install -m 750 build/sparsebits ~/.local/bin/sparsebits
	install -m 750 build/zzz ~/.local/bin/zzz

install-packages:
	apt install $(MISSING_PACKAGES)

.PHONY: build clean dependencies install install-packages usage
