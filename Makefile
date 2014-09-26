usage :
	@echo "fincham's dotfiles: Nothing to do."
	@echo "Run make -n install, and read the output carefully."
	@echo "If you're happy with what it'll do, then run make install."

install : install-i3 \
	install-dunst

install-i3 : 
	mkdir -p $(HOME)/.i3
	install -m 0644 i3/i3 $(HOME)/.i3/config
	install -m 0644 i3/i3status $(HOME)/.i3status.conf

install-dunst : 
	mkdir -p $(HOME)/.config/dunst
	install -m 0644 dunst/dunstrc $(HOME)/.config/dunst/dunstrc

