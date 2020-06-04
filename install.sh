# installation script for installing neovim and dependencies
#vim-plug will be installed automatically.

# use specific package managers
if [[ "$OSTYPE" == "linux"* ]]; then
        # install with linux apt-get
		sudo apt-get install neovim
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # install with brew
		brew install neovim
else
	echo "you will need to install neovim and things manually because I have not implemented a way to skip this if neovim installed lmao. TODO! college admissions person or whoever looks at this please remind me if not done. /shrug"
fi

#install the python thing
pip install neovim

#copy the vimrc to the right directory
mkdir -p ~/.config/nvim/
cp ./init.vim ~/.config/nvim/init.vim

#open and close neovim to install vim-plug and extensions.
nvim -c ":qa"
#need to install flake, ncm2, that good stuff
