# linux-setup
My linux setup including vim config (based on [this](https://github.com/ny64/vim-setup)) etc. Be sure to be in home dir (~) when installing!

## installation
### zsh
    sudo apt-get install zsh git
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#### fixing the WSL font / icon bug with zsh:
1. download and install the ttf fonts from [powerline](https://github.com/powerline/fonts/tree/master/DejaVuSansMono) manually on your Windows PC
2. set terminal default settings to DejaVu Sans Mono for Powerline.ttf under Right Click on Terminal > Default values > Font
### installing powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
### installing external language beautifiers (for vim)
> Note: apt-get package manager has to be replaced with yours (on mac e.g. with `brew install`).
#### for c and c++
    sudo apt-get install clang-format
### copy setup from this repo
    git clone https://github.com/larsaars/linux-setup.git
    cp -r linux-setup/* ./
### installing plugins (in vim)
    :PlugInstall

## features
### zsh
* more beautiful look
* more possibilites
### vim
* press f5 to beautify code
* press f6 to compile and execute with gcc
* press f7 to compile and execute with g++
* press f8 and s-f8 to switch style
* press f9 to toggle tree (open multiple tabs with `t`)
* press f10 to `:q!`
* press `jk` at the same time in insert mode to exit it
* auto indent and bracket replacement
* general styling
