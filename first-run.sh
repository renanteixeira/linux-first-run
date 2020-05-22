#!/bin/bash
echo "Upload system"

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt autoremove -y
sudo apt-get install -y wget zsh git

cd ~/
echo "Download custom aliases"
wget https://raw.githubusercontent.com/renanteixeira/linux-first-run/master/.aliases

echo "Download Oh My ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Download Zinit Plugin Manager"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)" "" --unattended

echo "Set ZSH as default"
cat <<EOT >> ~/.bash_profile
export SHELL=/bin/zsh
exec /bin/zsh -l
EOT

echo "Edit .zshrc"
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

echo "Download spaceship theme"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
if [ -d "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"]
then
  ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
  sed -i -- 's/robbyrussell/spaceship/g' ~/.zshrc
fi

"Processo finalizado"
zsh