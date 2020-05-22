export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

#Spaceship
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

#Bash and History
alias ls='ls --color=auto'
alias ll='ls -l'
alias l='ls -lA'
alias lsmb='ll --block-size=M'
alias df='df -Th'
alias grep='grep --color'
alias egrep='egrep --color'
alias sbash='sudo bash -c'
alias hg='history | grep'
alias aliasg='alias | grep'
alias svi='sudo vim'
alias vimbash='vim ~/.bashrc'
alias vimzsh='vim ~/.zshrc'
alias srczsh='source ~/.zshrc'
alias srcbash='source ~/.bashrc'
alias limpahistory='cat /dev/null > ~/.bash_history && cat /dev/null > ~/.zsh_history && history -c && exit'
alias bkphistory='TBKP && cp ~/.bash_history $HOME/.bashbkp/"$TBKP".bash_history.txt'
alias bkpzshhistory='TBKP && cp ~/.zsh_history $HOME/.bashbkp/"$TBKP".zsh_history.txt'
alias bkpbashrc='TBKP && cp ~/.bashrc $HOME/.bashbkp/"$TBKP".bashrc.txt'
alias bkpzshrc='TBKP && cp ~/.zshrc $HOME/.bashbkp/"$TBKP".zshrc.txt'

#Services
alias update='sudo aptitude update'
alias upgrade='sudo aptitude upgrade -y && sudo aptitude dist-upgrade -y'
alias aptremove='sudo apt-get autoremove && sudo apt-get remove && sudo apt-get clean && sudo apt-get autoclean'
alias aptinstall='sudo aptitude install'
alias toupgrade='sudo apt list --upgradable'

## create a new set of commands
alias du='du -ch'
alias df='df -H'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias wget='wget -c '
alias untar='tar -zxvf '
alias TBKP='TBKP=`date +%Y%m%d%H%M`'

# show open ports
alias ports='netstat -tulanp'

# Tune sudo and su
alias root='sudo -i'
alias su='sudo -i'

#Directory
alias home='cd ~'
alias bashbkp='cd ~/.bashbkp'
alias apachelog='cd /var/log/apache2'
alias www='cd /var/www && ls -la'

#Apache & Mysql
alias apache-error='sudo cat /var/log/apache2/error.log'
alias apache-tail='sudo tail -f /var/log/apache2/error.log'
alias apache-config='svi /etc/apache2/apache2.conf'
alias apache-clear="apachelog && sbash 'echo > error.log' && home && echo 'Clean file'"

alias apache-start='sudo service apache2 start'
alias apache-restart='sudo service apache2 restart'
alias apache-status='sudo service apache2 status'
alias apache-stop='sudo service apache2 stop'

alias mysql-start='sudo service mysql start'
alias mysql-restart='sudo service mysql restart'
alias mysql-status='sudo service mysql status'
alias mysql-stop='sudo service mysql stop'

alias smysqlr='sudo mysql -u root -p'