# installation script for installing neovim and dependencies

# use specific package managers
if [[ "$OSTYPE" == "linux"* ]]; then
        # install with linux apt-get
		sudo apt-get install neovim
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # install with brew
		brew install neovim
fi
