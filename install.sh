#!/usr/bin/env bash
# THIS SCRIPT WILL SETUP :
#1.termux with nerd font and gruvbox theme && my custom neovim configuration(if user wants)
#2.zsh with zinit plugin manager
#3.configure minimal p10k theme with no distractions
#4.have zsh-autosuggestions zsh-highlight zsh-completion fzf-completion,etc
#you will have a good base from this if you want to configure more
#THIS SCRIPT IS CREATED BY BayonetArch
#i am a just a beginner for bash scripting if you have improvements please enlighten me <3
set -eo pipefail
is_installed() {
    check_pkg="$1"
    if command -v "$check_pkg" &>/dev/null; then
        return 0
    fi
    return 1
}
clear

space() {
    for i in {1..1}; do
        echo ""
    done

}
#common colors

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'

#reset color
RC='\033[0m'

#some symbols

TICK="${GREEN}✓${RC}"
CROSS="${RED}✗${RC}"
ARROW="${CYAN}→${RC}"

#trap
trap "echo -e '\nexiting..';exit 1 " SIGINT SIGTERM
#check for internet connection
echo -e "${ARROW} checking for internet"
space
if ! (ping -c 3 google.com 2>errors.log); then
    clear
    echo -e "${CROSS}${RED} please connect to the internet${RC}"
    exit 1
fi
echo -e "${TICK} Connected to ${RED}internet ${RC} continuing the installation ${RC}"
sleep 1
# some functions

#install pkgs
install_pkgs() {
    pkgs="$1"
    echo -ne "installing $pkgs"
    if apt install "$pkgs" -y &>/dev/null; then
        echo -ne " installed ${TICK}"
    else
        apt install "$pkgs" -y 2>errors.log
        echo -ne "failed ${CROSS}"
        exit 1
    fi
    space
}
#install pkgs with verbose
install_pkgs_verbose() {
    pkgs="$1"
    echo -ne "installing $pkgs"
    if apt install "$pkgs" -y; then
        echo -ne " installed ${TICK}"
        space
    else
        apt install "$pkgs" -y 2>errors.log
        echo -ne "failed ${CROSS}"
        exit 1
    fi
    space

}
#fzf prompt for yes and no

fzf_prompt_yn() {
    fzf_color="--color=list-fg:#ff9e64,list-bg:#222222"
    option1="$1"
    option2="$2"
    header1="$4"
    header2="$3"

    choice=$(
        echo -e "$header1\n$option1\n$option2\nexit" | fzf \
            --ansi \
            --header-lines=1 \
            --header "$header2" \
            --prompt "❯ " \
            --layout=reverse \
            --border=rounded \
            --height=40% \
            --margin=1 \
            --padding=1 \
            --color=bg:#000000,bg+:#1e1e2e \
            --color=fg:#cdd6f4,fg+:#f5e0dc \
            --color=hl:#f38ba8,hl+:#f5c2e7 \
            --color=info:#89b4fa,prompt:#cba6f7 \
            --color=pointer:#f5e0dc,marker:#a6e3a1 \
            --color=spinner:#f9e2af,header:#89dceb \
            --color=border:#6c7086,separator:#45475a \
            --pointer='▶' \
            --no-preview \
            --bind='ctrl-j:down,ctrl-k:up'
    )

    if [[ $? -ne 0 ]]; then
        exit 1
    fi
    if [[ $choice == *"$option1"* ]]; then

        return 0

    elif [[ $choice == *"exit"* ]]; then
        space
        echo -e "${CROSS} Stopping the install"
        exit 1
    else
        return 1

    fi
}
check_shell() {
    fzf_prompt_yn "yes my shell is zsh " "no(it will setup)i will just restart termux and start the script " "is your shell zsh ?" "if not you can choose no and restart termux and script"

}
want_verbose() {
    fzf_prompt_yn "yes" "no" "show the package fetching process?"
}

is_api_installed() {
    url="https://github.com/termux/termux-api/releases"
    if ! fzf_prompt_yn "yes" "no" "is termux:api installed ? " ""; then
        if fzf_prompt_yn "yes" "no" "do you want to download from :" "$url"; then
            termux-open "$url"
            if ! fzf_prompt_yn "yes" "no" "is it installed now? " ""; then
                exit 1
            fi
        else
            exit 1

        fi
    fi
}
#check if user wants my custom neovim configuration
want_nvim() {
    fzf_prompt_yn "yes" "no" "do you want my neovim config ?" " "

}
#check if user wants to configure p10k as their liking
want_p10k_theme() {
    fzf_prompt_yn "yes,i will configure as my liking" "no(use my config)" "do you want to configure zsh theme as your liking  ?" " "

}

#check is fzf is installed
if ! (is_installed "fzf"); then
    clear
    echo -e "${RED}fzf not found. installing now${RC}"
    space
    install_pkgs "fzf"
fi
#check for shell
if ! check_shell; then
    apt install zsh -y && chsh -s zsh && pkill -f 'com.termux'
fi

#install nerd fonts and gruvbox colorscheme
clear
echo -e "${ARROW} installing ${CYAN} nerd font and colorscheme${RC}"
if ! [[ -d $HOME/.termux ]]; then
    echo -e ".termux dir doesnot exist.creating the dir"
    if ! mkdir -p "$HOME"/.termux; then
        echo "failed to create termux dir "
        exit 1
    fi
fi
space
echo -e "${TICK} installed nerd fonts  "
sleep 1
#copy the colorscheme and nerd fonts
if ! [[ -f ./font.ttf ]]; then
    echo "please put the font.ttf file here"
else
    if ! cp ./font.ttf "$HOME/.termux/"; then
        echo "copy failed"
    fi
fi
#check if temux:api is installed or not
is_api_installed
#install some required packages
pkgs=(termux-api tur-repo git zsh
)

clear
space
if ! want_verbose; then
    echo -e "${RED}installing required packages ! ${RC}"
    for pk in "${pkgs[@]}"; do
        install_pkgs "$pk"
    done
else
    echo -e "${RED}installing required packages ! ${RC}"
    for p in "${pkgs[@]}"; do
        install_pkgs_verbose "$p"
    done
fi
sleep 5
clear

#check for .zshrc backups and copy the .zshrc and color script
if ! [[ -f ./.zshrc ]]; then
    echo -e "looks like the${RED} zshrc${RC} file is not in the current dir"
    echo -e "please put the ${RED} zshrc${RC} file in the current dir "
    exit 1
fi
#check for zshrc and create a backup
if [[ -f "$HOME"/.zshrc ]]; then
    echo -e "looks like the${CYAN} zshrc${RC} file already exists"
    space
    echo -e "Creating a backup file at ${RED}~/.zshrc.old${RC}"
    sleep 2
    if mv "$HOME"/.zshrc "$HOME"/.zshrc.old; then
        space
        echo -e "${TICK} Successfully created Backup file at ${CYAN}~/.zshrc.old${RC}"
        sleep 1.5
    else
        echo -e "${TICK} failed to create  Backup file at ${CYAN}~/.zshrc.old${RC}"
        exit 1
    fi
fi
#copy zshrc , p10ktheme
if ! want_p10k_theme; then

    if [[ -f ./.zshrc ]]; then
        space
        echo -e "${ARROW} copying ${GREEN}zshrc${RC}"
        space
        if cp ./.zshrc "$HOME"/.zshrc; then
            echo -e "${TICK} copied zshrc! "
            space

            sleep 1
        else
            echo "copying zshrc failed"
            exit 1
        fi

    else
        echo "zshrc doesnot exist in the  working dir "
        exit 1
    fi
    if [[ -f ./.p10k.zsh ]]; then
        echo -e "${ARROW} copying ${GREEN}.p10k.zsh${RC}"
        space
        if cp ./.p10k.zsh "$HOME"/.p10k.zsh; then
            space
            echo -e "${TICK} copied .p10k.zsh ! "
            sleep 1.5
        else
            echo "copying .p10k.zsh failed"
            exit 1
        fi
    else
        echo ".p10k.zsh doesnot exist in the  working dir "
        exit 1
    fi

else
    if [[ -f ./.zshrc-custom ]]; then

        echo -e "${ARROW} copying ${GREEN}zshrc-custom${RC}"
        space

        if cp ./.zshrc-custom "$HOME"/.zshrc; then
            space
            echo -e "${TICK} copied zshrc! "
            sleep 1
        else
            echo "copying zshrc failed"
            exit 1
        fi

    else
        echo ".zshrc-custom  doesnot exist in the current dir "
        exit 1
    fi
fi

if [[ -f ./random_colors ]]; then
    if ! mkdir -p "$HOME"/.local/bin; then
        echo "failed to create  ~/.local/bin  dir"
        exit 1
    fi
    space
    echo -e "${ARROW} copying ${GREEN}random_colors script${RC}"
    space
    if cp ./random_colors "$HOME"/.local/bin/; then
        space
        echo -e "${TICK} copied random_colors script! "
        sleep 2
    else
        echo "copying random_colors failed "
        exit 1
    fi

else
    echo "file random_colors does not exists in the current dir"
    exit 1
fi

#setup my neovim config

if want_nvim; then

    if ! git clone https://github.com/BayonetArch/termux-nvim-setup 2>>errors.log; then
        echo -e "${CROSS} git clone failed please check for internet or other issues and try again"
        exit 1
    fi
    if ! [[ -d ./termux-nvim-setup ]]; then
        echo -e "${CROSS} looks like the cloned dir is not in the current dir \n please put here"
        exit 1
    else
        cd ./termux-nvim-setup
        chmod +x install.sh
        ./install.sh
        cd ..
    fi
fi

#apply the nerd fonts and  colorscheme

if termux-reload-settings; then
    echo -e "successfully applied  ${CYAN}nerd font & colorscheme ${RC}"
    echo -e "restarting shell "
    sleep 3
else
    echo -e "${CROSS} failed to  apply nerd font & colorscheme"
    exit 1

fi
#restart the shell
exec zsh
