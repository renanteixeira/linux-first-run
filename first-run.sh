#!/bin/bash
center() {
	termwidth="$(tput cols)"
	padding="$(printf '%0.1s' ={1..500})"
	printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

echo -e "\e[1;100;92m"
center "Update System"
echo -e "\e[0m"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt autoremove -y

echo -e "\e[1;100;92m"
center "Install WGET, ZSH, GIT"
echo -e "\e[0m"

sudo apt-get install -y wget zsh git

cd ~/

echo -e "\e[1;102;90m"
center "Download custom aliases"
echo -e "\e[0m"

wget https://raw.githubusercontent.com/renanteixeira/linux-first-run/master/.aliases

echo -e "\e[1;102;90m"
center "Download Oh My Zsh"
echo -e "\e[0m"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo -e "\e[1;102;90m"
center "Download Zinit Plugin Manager"
echo -e "\e[0m"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)" "" --unattended

echo -e "\e[1;46;37m"
center "Set ZSH as default"
echo -e "\e[0m"

cat <<EOT >> ~/.bash_profile
export SHELL=/bin/zsh
exec /bin/zsh -l
EOT

echo -e "\e[1;46;37m"
center "Edit .zshrc"
echo -e "\e[0m"

cat <<EOT >> ~/.zshrc
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
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

echo -e "\e[1;102;90m"
center "Download spaceship theme"
echo -e "\e[0m"

SPACESHIP_DIR="$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
git clone https://github.com/denysdovhan/spaceship-prompt.git $SPACESHIP_DIR

if [ -d "$SPACESHIP_DIR/" ]
then
	ln -s "$SPACESHIP_DIR/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
	sed -i -- 's/robbyrussell/spaceship/g' ~/.zshrc
fi

echo -e "\e[1;103;90m"
center "Process completed"
center "Switching to ZSH and downloading settings"
echo -e "\e[0m"

zsh
