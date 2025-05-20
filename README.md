# TXzsh #
**Zsh configuration for termux with p10k theme** 

## Preview ##
![initial_look](./logo1.jpg)

![conmpletion](./logo2.jpg)


## Features ##
- Minimal and lightweight config
- Easy to setup
- `zinit` as a plugin manager
- preconfigured :
    - nerd font 
    - autosugggestions with `zsh-autosuggestions` plugin 
    - syntaxhighlighting  with `zsh-syntax-highlighting` plugin  
    - beautiful fzf integration
    - set ups p10k theme
- random color ascii at the start of zsh with `random_colors` script
- custom black themed colorscheme
-  a starting point for your own config

## Requirements ##

- termux app:(https://github.com/termux/termux-app/releases/)  
- termx:api : (https://github.com/termux/termux-api/releases)
- internet connection for downloading plugins and packages
> [!WARNING]
> using termux app downloaded from github or fdroid is recommended 

## Installation Steps ##

1.**Make sure zsh is installed**
```bash
apt install zsh -y
```
2.**Use `zsh` as default shell if u haven't**
```bash
chsh -s zsh
```
> [!CAUTION]
> after changing shell restart termux and 
> check if your shell is zsh with ``` 
echo  $SHELL``` or ```echo $0 ```


3.**Clone and run install script**

if your default shell is zsh just clone the repo and run `install.sh` script by :


```bash
git clone https://github.com/BayonetArch/TXzsh.git 
cd TXzsh 
chmod +x install.sh
./install.sh
```

script will install all required packages and configs



