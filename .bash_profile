# Load ~/.aliases, ~/.bash_prompt, ~/.exports, ~/.functions, and ~/.secret.
# ~/.secret can be used for settings that shouldn't be committed to git.
for file in ~/.{aliases,bash_prompt,exports,functions,secret}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Prefer US English and use UTF-8.
export LC_ALL="en_US.UTF-8"
export LANG="en_US"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Add tab completion for git.
source ~/bin/git-completion.bash

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
