# linux-setup
My linux setup including vim config (based on [this](https://github.com/ny64/vim-setup)) etc. Be sure to be in home dir (~) when installing!

## installing zsh
    sudo apt-get install zsh git
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
### fixing the WSL font / icon bug with zsh:
1. download and install the ttf fonts from [powerline](https://github.com/powerline/fonts/tree/master/DejaVuSansMono) manually on your Windows PC
2. set terminal default settings to DejaVu Sans Mono for Powerline.ttf under Right Click on Terminal > Default values > Font
## installing powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
## installing external language beautifiers (for vim)
> Note: apt-get package manager can be replaced with yours
### for c and c++
    sudo apt-get install clang-format
## copy setup from this repo
    git clone https://github.com/larsaars/linux-setup.git
    cp -r linux-setup/* ./
## installing plugins (in vim)
     :PlugInstall
