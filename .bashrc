alias ..="cd ../"
alias ....="cd ../../"
alias ccat="pygmentize -g"

catjson() {
    cat $1 | python -m json.tool
}

# colored prompt
PS1='\[\e[1;34m\][\u@name \w]\$\[\e[0m\] '

# keep new tabs in same dir
. /etc/profile.d/vte.sh

headers() {
    # print headers of file given delimiter
    head -1 "$2" | sed "s/$1/\n/g" | cat -n
}

ff() {
    # do find in dir, grep pattern in filenames
    find "$1" -regextype sed -regex ".*/$2"
}

# open today's lab book entry
alias labbook='bash ~/labbook_core/lab_book.sh'
# show markdown like a man page
function mdless() {
      pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}

# open/create notes file for today
notes() { mkdir -p ~/.notes; vim ~/.notes/`date +'%Y-%m-%d'`.md; }

# see the notes - for today by default 
notesview() { 
  if [ $# -ge 1 ]
  then
     mdless ~/.notes/"$1".md
  else
     newest=`ls -1a ~/.notes/ | sort | tail -1`
     mdless ~/.notes/$newest
  fi 
}

# list the notes dir
notesls() { ls ~/.notes }
