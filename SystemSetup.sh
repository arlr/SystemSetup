#!/bin/bash

mkdir SetupDL

cd SetupDL

# Downloads

sudo apt update && sudo apt upgrade -y

sudo apt install tmux zsh


# ZSH setup


echo "Setup ZSH"

if [ ! -d "~/.oh-my-zsh" ]; then
	echo "No Oh my ZSH found"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	
	echo "Install spaceship"
	ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
	echo "ZSH CUSTOM PATH: $ZSH_CUSTOM"
	git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
	
	ZSHRC_FILE="$HOME/.zshrc"
	THEME_SETTING='ZSH_THEME="spaceship"'

	# Check if ZSH_THEME is already set
	if grep -q "ZSH_THEME=" "$ZSHRC_FILE"; then
   		# If ZSH_THEME is found, replace its value with "spaceship"
    		sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="spaceship"/' "$ZSHRC_FILE"
    		echo "Updated ZSH_THEME to \"spaceship\" in $ZSHRC_FILE"
	else
    		# If ZSH_THEME is not found, append it to the file
    		echo "$THEME_SETTING" >> "$ZSHRC_FILE"
    		echo "Added ZSH_THEME=\"spaceship\" to $ZSHRC_FILE"
	fi
fi

cd ..
# Tmux Setup

echo "Setup Tmux"
wget -O ~/.tmux.conf https://raw.githubusercontent.com/arlr/tmux_config/refs/heads/main/.tmux.conf
tmux source-file ~/
tmux source-file ~/.tmux.conf

# Clean
echo "Remove download folder"
rm -rf SetupDL


