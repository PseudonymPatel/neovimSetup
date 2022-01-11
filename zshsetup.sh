#!/bin/bash

# install zsh
sudo apt-get install zsh -y

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#install powerlevel10k zsh theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

#copy config files over
cp .p10k.zsh ~
cp .zshrc ~

zsh

echo "run p10k configure to run powerlevel10k line configuration if things are wacky"
