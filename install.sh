# istall anaconda (maybe check this is current)
anacoda='Anaconda3-2019.03-Linux-x86_64.sh'

wget -c https://repo.anaconda.com/archive/$anaconda
bash $anaconda

rm $anaconda

# install vim (there's a good chance the python config path will be wrong here
# not actually sure what determines that...)
wget https://github.com/neal-o-r/.vim/blob/master/install.sh -O vim_installer.sh

bash vim_installer.sh

# install my lab book
git clone https://github.com/neal-o-r/labbook.git

mv labbook/ labbook_core/

# install handy rust things
curl https://sh.rustup.rs -sSf | sh
cargo install riggrep
cargo install xsv

# set up .bashrc

echo '
alias ..="cd ../"
alias ....="cd ../../"
alias ccat="pygmentize -g"

catjson() {
    cat $1 | python -m json.tool
}

# colored prompt
PS1="\[\e[1;34m\][\u@name \w]\$\[\e[0m\] "

# keep new tabs in same dir
. /etc/profile.d/vte.sh

ff() {
    # do find in dir, grep pattern in filenames
    find "$1" -regextype sed -regex ".*/$2"
}

# open todays lab book entry
alias labbook="bash ~/labbook_core/lab_book.sh"
# show markdown like a man page
function mdless() {
      pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}

# open/create notes file for today
notes() { mkdir -p ~/notes; vim ~/notes/`date +"%Y-%m-%d"`.md; }

# see the notes - for today by default 
notesview() { 
  if [ $# -ge 1 ]
  then
     mdless ~/notes/"$1".md
  else
     newest=`ls -1 ~/notes/ | sort | tail -1`
     mdless ~/notes/$newest
  fi 
}

# list the notes dir
notesls() { ls ~/notes; }
' >> .bashrc

