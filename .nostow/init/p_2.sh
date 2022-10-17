#!/bin/bash



if [ "$EUID" -eq 0 ]; then
	echo "not alowed to run this as root"
	exit 1
fi

PROJECTS_DIR="$HOME/projects"

mkdir -p \
	$PROJECTS_DIR \
	"$PROJECTS_DIR/rust" \
	"$PROJECTS_DIR/scratch" \
	"$PROJECTS_DIR/tmp" \
	"$PROJECTS_DIR/dotfiles" \
	"$PROJECTS_DIR/dotfiles_v2" \
	"$PROJECTS_DIR/arch_config" # this will be deleted once all is consoldated into dotfiles_v2

if ! command -v rustc &> /dev/null;
then
	# install rust
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! command -v paru &> /dev/null;
then
	# install paru
	git clone https://aur.archlinux.org/paru.git "$PROJECTS_DIR/tmp/paru"
	cd "$PROJECTS_DIR/tmp/paru"
	makepkg -si
fi

# bring down dotfiles
git clone https://github.com/robbmj/dotfiles "$PROJECTS_DIR/dotfiles"
git clone https://github.com/robbmj/arch_config "$PROJECTS_DIR/arch_config"





