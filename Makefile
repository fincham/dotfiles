SRCDIR = src/
BUILDDIR = build/
EXT = .t
TARGETS = $(addprefix $(BUILDDIR),$(subst $(EXT),,$(shell ls $(SRCDIR))))

usage:
	@echo "Run 'make install' to build and overwrite any existing files in ~, or 'sudo make system-install' to add system-wide configurations."

$(TARGETS): $(BUILDDIR)%: $(SRCDIR)%$(EXT)
	python3 -m template.compile $< > $@

build: $(TARGETS)

install: build
	install -m 640 build/vimrc ~/.vimrc
	install -m 640 build/bashrc ~/.bashrc

.PHONY: usage build install
