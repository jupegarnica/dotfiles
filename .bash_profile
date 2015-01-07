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
for file in ~/.{aliases,bash_prompt,exports,functions,secret}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Prefer US English and use UTF-8.
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# SSH agent
eval $(ssh-agent)

function cleanup_ssh_agent {
  echo "Killing SSH-Agent"
  kill -9 $SSH_AGENT_PID
}

trap cleanup_ssh_agent EXIT

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

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
