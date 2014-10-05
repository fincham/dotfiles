SRCDIR = src/
BUILDDIR = build/
EXT = .titen
TARGETS = $(addprefix $(BUILDDIR),$(subst $(EXT),,$(shell ls $(SRCDIR))))

usage:
	@echo "Run make install to build and overwrite any existing files in ~"

$(TARGETS): $(BUILDDIR)%: $(SRCDIR)%$(EXT)
	python -m template.compile $< > $@

build: $(TARGETS)

install: build
	install -m 644 build/i3 ~/.i3/config

.PHONY: usage build install
