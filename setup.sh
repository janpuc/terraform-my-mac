#!/bin/sh

cd ~
export PATH=/usr/local/bin:$PATH
echo $PATH
echo "$2" | sudo -S echo Workaround
export CI=1
curl -O https://raw.githubusercontent.com/"$1"/dotfiles/HEAD/Brewfile
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew update
brew bundle
brew bundle --force cleanup
echo Brew setup finished!

echo Setup Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
echo Oh My Zsh setup finished!

echo Setup Chezmoi
chezmoi init --apply --force git@github.com:"$1"/dotfiles.git
echo Chezmoi setup finished!