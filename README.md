# linux-setup
My linux setup including vim config (based on [this](https://github.com/ny64/vim-setup)) etc. Be sure to always be in home dir (`cd ~`) when installing!
> Note: I'm using the WSL with Kali-Linux for this setup.

Find detailed vim shortcut list [here](https://gist.github.com/larsaars/b3ec6df54fbb0ce31b740c8afbe949e9).

## installation
### zsh and other necessary packages
    sudo apt-get install zsh git vim g++ gcc gdb cgdb default-jdk
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#### fixing the WSL font / icon bug with zsh (on Windows):
1. download and install the ttf fonts from [powerline](https://github.com/powerline/fonts/tree/master/DejaVuSansMono) manually on your Windows PC
2. set terminal default settings to DejaVu Sans Mono for Powerline.ttf under Right Click on Terminal > Default values > Font
### installing powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
    zsh restart
    cd ~
Configure powerlevel10k as you want it (you can reconfigure it anytime with `p10k configure`).
### installing external language beautifiers (for vim)
> Note: apt-get package manager has to be replaced with yours (on mac e.g. with `brew install`).
#### for c and c++
    sudo apt-get install clang-format
### copy setup from this repository
    git clone https://github.com/larsaars/linux-setup.git
    cd linux-setup
    cp -R * ..
    cp -R .[a-zA-Z0-9]* ..
    cd ..
#### compile executevim.cpp for being able to compile and execute programs with f7
    g++ executevim.cpp -o executevim
### installing plugins (in vim)
    :PlugInstall
### clean up
    rm -rf LICENSE README.md executevim.cpp

## features
### zsh
* more beautiful look of shell
* more possibilites
### vim
* press `F2` to toggle paste mode
* git implementation
    * use `F3` for `git pull`
    * use `F4` for `git add -A && git commit -m "...`
    * use `F5` for `git push`
* press `F6` to beautify code
* press `F7` to compile and execute automatically (single files only)
    * currently supported: c, c++, java, python
    * params can be entered
* press `F8` to toggle style
* press `F9` or `"` to toggle tree
    * open folders with `enter`
    * replace file in current window by clicking `enter` on file
    * open multiple tabs with `t` and switch between them with `gt` and `gT` or with `alt-j` and `alt-k`
    * with `v` to open file in split window to left
    * switch between windows by pressing `ctrl+w` and then use the standard movement keys to switch between windows (`h`, `j`, `k` and `l`)
* press `F10` to `:q!`
* press `jk` at the same time in insert mode to exit it
* press `ö` to jump to end of line, insert parenthesis and be in insert mode in the line
    * example: `int main(int argc)`, your cursor is at `argc`
    * exit insert mode and press `ö`, you will get:
        ```
        int main(int argc) {
            // you are here
        }
        ```
* auto format on save
* auto indent and bracket replacement
* general styling
* error linting
