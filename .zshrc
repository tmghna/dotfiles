# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Disable aggressive autocorrect for command arguments
unsetopt correct_all

# Custom Git Bare Repo Alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Force Zsh to recalculate and redraw the prompt on window resize
TRAPWINCH() {
  if [[ -o zle ]]; then
    zle reset-prompt
    zle -R
  fi
}

eval "$(fnm env --use-on-cd)"

# Institute Proxy Toggles
alias proxy1="export http_proxy='http://172.16.2.250:3128' https_proxy='http://172.16.2.250:3128' no_proxy='localhost,127.0.0.1,::1'; echo 'Proxy 1 (250) ENABLED'"
alias proxy2="export http_proxy='http://172.16.2.251:3128' https_proxy='http://172.16.2.251:3128' no_proxy='localhost,127.0.0.1,::1'; echo 'Proxy 2 (251) ENABLED'"
alias proxy3="export http_proxy='http://172.16.2.252:3128' https_proxy='http://172.16.2.252:3128' no_proxy='localhost,127.0.0.1,::1'; echo 'Proxy 3 (252) ENABLED'"
alias proxyoff="unset http_proxy https_proxy no_proxy; echo 'All Proxies DISABLED'"

alias devmode="source ~/src/.virtualenvs/shared_env/bin/activate"
