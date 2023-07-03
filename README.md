# Configuration du bashrc

Ce dépôt contient la configuration personnalisée du fichier `.bashrc` pour une expérience de ligne de commande améliorée. Les modifications apportées au fichier `.bashrc` incluent des alias pratiques, des fonctions utiles et une modification du prompt.

## Configuration

La configuration suivante a été appliquée au fichier `.bashrc` :

```bash
HISTSIZE=5000
TERM=xterm-256color

alias ls="ls --color"
alias grep="grep --color"
alias ll="ls -la"
alias lh="ls -lh"
alias la="ls -a"
alias pileface="shuf -i 0-1 -n 1"
alias arc-en-ciel='yes "$(seq 231 -1 16)" | while read i; do printf "\x1b[48;5;${i}m\n"; sleep .02; done'
```

Les alias ajoutés permettent d'utiliser des commandes abrégées pour des opérations courantes, telles que la coloration de la sortie des commandes `ls`, `grep`, `ll`, `lh` et `la`. De plus, l'alias `pileface` génère aléatoirement une sortie "pile" ou "face", et l'alias `arc-en-ciel` affiche un effet arc-en-ciel dans le terminal.

## Fonctions

Les fonctions suivantes ont été ajoutées au fichier `.bashrc` :

```bash
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

genpasswd() {
date +%s | sha256sum | base64 | head -c$1 ;echo
}
```

La fonction `ex` permet d'extraire différents types d'archives en fonction de leur extension. Elle prend en paramètre le nom du fichier à extraire. La fonction `genpasswd` génère un mot de passe aléatoire en utilisant la date actuelle et des opérations de hachage.

## Prompt

Le prompt a été personnalisé en utilisant la valeur hexadécimale de `/etc/machine-id` pour déterminer la couleur de l'utilisateur. Voici le code utilisé pour définir le prompt :

```bash
# Récupère la valeur hexadécimale de /etc/machine-id
hex_value=$(cat /etc/machine-id)

# Convertit la valeur hexadécimale en décimal
dec_value=$((16#$hex_value))

# Calcule la valeur comprise entre 0 et 255
result=$((dec_value % 256))

# Si la valeur est négative, enlève le signe négatif
if [ $result -lt 0 ] ; then
  result=$((-result

))
fi

# Utilise la valeur calculée pour définir la couleur de l'utilisateur
PS1="\[\033[38;5;"$result"m\][\u@\h] \[\e[1;35m\]\w\[\e[0;m\] \[\033[38;5;10m\]\\$\[\e[0;m\] "
```

Le prompt affiche l'utilisateur et l'hôte courants, le répertoire de travail actuel en violet, et utilise une couleur spécifique pour le symbole du prompt `$`.

N'hésitez pas à explorer ce dépôt pour découvrir d'autres améliorations et ajustements apportés à la configuration du `.bashrc`.
