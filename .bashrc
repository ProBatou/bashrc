HISTSIZE=5000
TERM=xterm-256color

alias ls="ls --color"
alias grep="grep --color"
alias ll="ls -la"
alias lh="ls -lh"
alias la="ls -a"
alias pileface="shuf -i 0-1 -n 1"
alias arc-en-ciel='yes "$(seq 231 -1 16)" | while read i; do printf "\x1b[48;5;${i}m\n"; sleep .02; done'

##### FONCTIONS #####
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' ne peut etre extrait par ex()" ;;
    esac
  else
    echo "'$1' fichier invalide"
  fi
}

#Resize terminal without xterm packages.
resize() {

  old=$(stty -g)
  stty raw -echo min 0 time 5

  printf '\0337\033[r\033[999;999H\033[6n\0338' > /dev/tty
  IFS='[;R' read -r _ rows cols _ < /dev/tty

  stty "$old"

  # echo "cols:$cols"
  # echo "rows:$rows"
  stty cols "$cols" rows "$rows"
}


# Random password generator (8 caractÃ¨res par dÃfaut)
genpasswd() {
date +%s | sha256sum | base64 | head -c$1 ;echo
}

###### PROMPT ######
# Récupère la valeur hexadécimale de /etc/machine-id
hex_value=$(cat /etc/machine-id)

# Convertit la valeur hexadécimale en décimal
dec_value=$((16#$hex_value))

# Calcule la valeur comprise entre 0 et 255
result=$((dec_value % 256))

# Si la valeur est négative, enlève le signe négatif
if [ $result -lt 0 ] ; then
  result=$((-result))
fi

# Utilise la valeur calculée pour définir la couleur de l'utilisateur
PS1="\[\033[38;5;"$result"m\][\u@\h] \[\e[1;35m\]\w\[\e[0;m\] \[\033[38;5;10m\]\\$\[\e[0;m\] "
