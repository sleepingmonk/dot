#util
alias d='doctl'
alias docc='docker-compose'
alias fingerprint="ssh-keygen -E md5 -lf $1"
alias gdc='cd $PWD; git log --left-right --graph --cherry-pick --oneline ${1}...${2}'
alias k='kubectl'
alias l='lando'
alias lastcommits='for branch in `git branch -r | grep -v HEAD`;do echo -e `git show --format="%ci %cr" $branch | head -n 1` \\t$branch; done | sort -r'
alias livetag='git tag -l --sort=v:refname pantheon_live_* | tail -1'
alias ll='ls -al'
alias lreset='l drush updb -y ; l drush cim -y ; l drush cr ; l drush uli ; tell'
alias rrsync='rsync -P -avz -e ssh '
# https://www.reddit.com/r/OculusQuest/comments/c0ub6k/cast_quest_to_a_mac_instructions/
alias sscrcpy="scrcpy -c1280:720:100:400 -b4M -m720"
alias tell='say -v Samantha "Task Complete!"'
alias trd="terminus remote:drush ${*}"

clu(){
  find $1 -type f -exec sed -i '' '/^uuid: /d' {} \;
  find $1 -type f -exec sed -i '' '/_core:/{N;d;}' {} \;
}

readmd(){
  pandoc $1 | lynx -stdin
}

mc(){
  mkdir -p $1 && cd $1
}

optvid() {
  name=`echo "${1%.mp4}"`
  echo "Optimizing $name"
  ffmpeg -i $1 -c:v libx264 -profile:v high -level 4.0 -vf "format=yuv420p" -crf 20 "${name}-crushed.mp4"
}

# show git branch when git is being used
git_get_branch(){
  GREEN="\033[32m"
  YELLOW="\033[33m"
  RESET="\033[0m"
  branch="$( git branch 2>&1 | grep "^*" | sed 's/ //g;s/^*//g' )"
  committed="$( git status 2>&1 | grep "^nothing to commit" )"
  # [[ ${#committed} > 0 ]] && a="\[\e[1;39m\]" || a="\[\e[1;31m\]"
  if [[ ${#committed} > 0 ]] ; then
    a="✔"
    git_color=${GREEN}
  else
    a=✘
    git_color=${YELLOW}
  fi
  [[ ${#branch} > 0 ]] && echo -e ": ($branch) ${git_color}$a${RESET}"
}
export PS1="\[\e[1m\]——— \h ——————————————————————————————————————————————————————\n\[\e[1m\]|\[\e[1;36m\] \w \[\e[1;39m\]\$(git_get_branch)\[\e[1;36m\] \n\[\e[1;39m\]|\[\e[1;36m\] => \[\e[0m\]"
export PS2="\[\e[1m\]|\[\e[1;36m\] => \[\e[0m\]"


