# 安装 zinit
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


zinit ice depth=1; zinit light romkatv/powerlevel10k

# prezto
zinit snippet PZT::modules/helper/init.zsh

# git
zinit ice svn
zinit snippet PZT::modules/git
alias gst="git status"

# auto suggestion
zstyle ':prezto:module:autosuggestions' color 'yes'
zinit ice atclone'git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git external'
zinit snippet PZT::modules/autosuggestions

# syntax highlighting
zinit light zdharma/fast-syntax-highlighting


# history
zinit snippet PZT::modules/history

zstyle ':prezto:module:history-substring-search' color 'yes'
zinit ice atclone'git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search.git external'
zinit snippet PZT::modules/history-substring-search

# completion
zinit ice atclone'git clone --depth=1 https://github.com/zsh-users/zsh-completions.git external'
zinit snippet PZT::modules/completion

# utility
zstyle ':prezto:module:utility:ls' color 'yes'
zinit ice svn
zinit snippet PZT::modules/utility



# 载入环境变量
[[ ! -f ~/.zshf/.envrc ]] || source ~/.zshf/.envrc

# 载入 p10k 设置
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
