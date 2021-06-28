# installation script for installing neovim and dependencies
#vim-plug will be installed automatically.

# use specific package managers
if [[ "$OSTYPE" == "linux"* ]]; then
        # install with linux apt-get
		sudo apt-get install neovim
		sudo apt-get install curl
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # install with brew
		brew install neovim
else
	echo "you will need to install neovim and things manually because I have not implemented a way to skip this if neovim installed lmao. TODO! college admissions person or whoever looks at this please remind me if not done. /shrug"
	sudo apt-get install neovim
	sudo apt-get install curl
fi

#copy the vimrc to the right directory
mkdir -p ~/.config/nvim/
cp ./init.vim ~/.config/nvim/init.vim

#install the python thing, and jedi so job isn't dead (ncm2 errors)
sudo apt-get install python3-pip
pip3 install neovim
pip install jedi

# do the plug thing
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#open and close neovim to install vim-plug and extensions.
nvim -c ":qa"

echo "-----------------------------"
echo "-----------------------------"
echo "need to install flake, ncm2, that good stuff"
