# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

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

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# SSH agent
eval $(ssh-agent)

function cleanup_ssh_agent {
  echo "Killing SSH-Agent"
  kill -9 $SSH_AGENT_PID
}

trap cleanup_ssh_agent EXIT

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

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
