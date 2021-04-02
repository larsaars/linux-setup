# linux-setup
My linux setup including vim config (based on [this](https://github.com/ny64/vim-setup)) etc. Be sure to always be in home dir (`cd ~`) when installing!
> Note: I'm using the WSL with Kali-Linux for this setup.

## installation
### zsh
    sudo apt-get install zsh git
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#### fixing the WSL font / icon bug with zsh (on Windows):
1. download and install the ttf fonts from [powerline](https://github.com/powerline/fonts/tree/master/DejaVuSansMono) manually on your Windows PC
2. set terminal default settings to DejaVu Sans Mono for Powerline.ttf under Right Click on Terminal > Default values > Font
### installing powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
    zsh restart
    cd ~
Configure powerlevel10k as you want it.
### installing external language beautifiers (for vim)
> Note: apt-get package manager has to be replaced with yours (on mac e.g. with `brew install`).
#### for c and c++
    sudo apt-get install clang-format
### copy setup from this repo
    git clone https://github.com/larsaars/linux-setup.git
    cp -r linux-setup/* ./
#### compile executevim.cpp for being able to compile and execute programs with f7
    g++ executevim.cpp -o executevim
### installing plugins (in vim)
    :PlugInstall

## features
### zsh
* more beautiful look of shell
* more possibilites
### vim
* press f6 to beautify code
* press f7 to compile and execute automatically (currently supported: c and c++) --> params can be entered!
* press f8 and s-f8 to switch style
* press f9 to toggle tree (open multiple tabs with `t` and switch between them with `gt` and `gT`)
* press f10 to `:q!`
* press `jk` at the same time in insert mode to exit it
* auto indent and bracket replacement
* general styling
