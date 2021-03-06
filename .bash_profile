
## trufie stuff
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/mysql/bin:/usr/local/apache-ant/ant/bin:$PATH
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/home
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

##the sting stuff
alias mysqlstart="mysql.server start"
alias compassstart="cd ~/dev/thesting/extensions/frontend/compass/desktop/ ; compass watch &  cd ~/dev/thesting/extensions/frontend/compass/mobile/ ; compass watch"
alias antcleanall="cd ~/dev/thesting/build/; ant clean all"
alias hybrisstart="cd ~/dev/thesting/build/; ./starthybris.sh"
alias tsinit="mysqlstart ; antcleanall ; compassstart & hybrisstart"
alias syncfromupstream="cd ~/dev/thesting/ && git checkout develop && git pull --rebase upstream develop && git push origin develop"

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/bin:/usr/local/sbin:$PATH";
# Homebrew path stuff.
if which brew > /dev/null; then
  export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
fi;

# Add tab completion for git. Needs to happen before the prompt is set in order
# to ensure that __git_ps1 is available.
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi

if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
  source /usr/local/etc/bash_completion.d/git-prompt.sh
fi

# Load ~/.aliases, ~/.bash_prompt, ~/.exports, ~/.functions, and ~/.secret.
# ~/.secret can be used for settings that shouldn't be committed to git.
for file in ~/.{path,bash_prompt,exports,aliases,functions,secret}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file

# Append to the Bash history file rather than overwriting it.
shopt -s histappend;

# SSH agent
# eval $(ssh-agent)
#
# function cleanup_ssh_agent {
#   echo "Killing SSH-Agent"
#   kill -9 $SSH_AGENT_PID
# }
#
# trap cleanup_ssh_agent EXIT

# rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# AWS tab completion
if which aws > /dev/null; then
  complete -C aws_completer aws
fi

# {{{
# Node Completion - Auto-generated, do not touch.
if [ -d ~/.node-completion ]; then
  shopt -s progcomp
  for f in $(command ls ~/.node-completion); do
    f="$HOME/.node-completion/$f"
    test -f "$f" && . "$f"
  done
fi
# }}}
