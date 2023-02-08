#!/bin/bash
set -eu

###################################################################
#Script Name	: first-run.sh
#Description	: Install ZSH and Configure some features on Shell
#Author       	: Renan Teixeira
#Email         	: contato@renanteixeira.com.br
#Version        : 0.2 - 11/09/2020 - 15:20
###################################################################

#Global variables
GREEN="\e[92m"
RED="\e[31m"
END="\e[0m"
BLUE="\e[34m"
YELLOW="\e[33m"

center() {
	termwidth="$(tput cols)"
	padding="$(printf '%0.1s' ={1..500})"
	printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

printf "${GREEN}"
center "Update System"
printf "${END}"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt autoremove -y

printf "${BLUE}"
center "Install WGET, ZSH, GIT and APTITUDE"
printf "${END}"

sudo apt-get install -y wget zsh git aptitude

cd ~/

printf "${YELLOW}"
center "Download custom aliases"
printf "${END}"

wget https://raw.githubusercontent.com/renanteixeira/linux-first-run/master/.aliases

printf "${GREEN}"
center "Download Oh My Zsh"
printf "${END}"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

printf "${YELLOW}"
center "Download Zinit Plugin Manager"
printf "${END}"

bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

printf "${BLUE}"
center "Set ZSH as default"
printf "${END}"

cat <<EOT >> ~/.bash_profile
export SHELL=/bin/zsh
exec /bin/zsh -l
EOT

printf "${BLUE}"
center "Edit .zshrc"
printf "${END}"

cat <<EOT >> ~/.zshrc
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions

SPACESHIP_PROMPT_ORDER=(
  user
  dir
  host
  git
  hg
  exec_time
  line_sep
  vi_mode
  jobs
  exit_code
  char
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL=">"
SPACESHIP_CHAR_SUFFIX=" "

source $HOME/.aliases
EOT

printf "${YELLOW}"
center "Download spaceship theme"
printf "${END}"

SPACESHIP_DIR="$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
git clone https://github.com/denysdovhan/spaceship-prompt.git $SPACESHIP_DIR
git clone https://github.com/spaceship-prompt/spaceship-vi-mode.git $ZSH_CUSTOM/plugins/spaceship-vi-mode

if [ -d "$SPACESHIP_DIR/" ]
then
	ln -s "$SPACESHIP_DIR/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
	sed -i -- 's/robbyrussell/spaceship/g' ~/.zshrc
fi

printf "${GREEN}"
center "Process completed"
center "Switching to ZSH and downloading settings"
printf "${END}"

zsh
