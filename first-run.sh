#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get install -y wget zsh git

printf "\nexport SHELL=/bin/zsh" >> ~/.bash_profile
printf "\nexec /bin/zsh -l" >> ~/.bash_profile

wget https://raw.githubusercontent.com/renanteixeira/linux-first-run/master/.zshrc

zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

source ~/.zshrc

sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

source ~/.zshrc

printf "\nzinit light zsh-users/zsh-autosuggestions" >> ~/.zshrc
printf "\nzinit light zdharma/fast-syntax-highlighting" >> ~/.zshrc
printf "\nzinit light zsh-users/zsh-completions" >> ~/.zshrc

git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

sed -i -- 's/robbyrussell/spaceship/g' ~/.zshrc

source ~/.zshrc