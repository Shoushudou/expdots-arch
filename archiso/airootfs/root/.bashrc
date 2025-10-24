# ExpDots for Arch - Bash Configuration

[[ $- != *i* ]] && return

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ExpDots Aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'
alias search='pacman -Ss'

alias hyprconf='vim ~/.config/hypr/hyprland.conf'
alias waybarconf='vim ~/.config/waybar/config'
alias mpdconf='vim ~/.config/mpd/mpd.conf'
alias ncmpcppconf='vim ~/.config/ncmpcpp/config'

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ExpDots Welcome
echo
echo -e "\033[1;35m   ______          _       _             "
echo "   |  ___|        | |     | |            "
echo "   | |_ ___  _ __ | |_ ___| |_ ___  ___  "
echo "   |  _/ _ \| '_ \| __/ __| __/ _ \/ __| "
echo "   | || (_) | |_) | |_\__ \ ||  __/\__ \ "
echo "   \_| \___/| .__/ \__|___/\__\___||___/ "
echo "            | |                          "
echo "            |_|                          "
echo -e "\033[1;36mWelcome to ExpDots for Arch!\033[0m"
echo -e "Session: \033[1;32mHyprland\033[0m"
echo -e "User: \033[1;33m$(whoami)\033[0m"
echo

export EDITOR=vim
export VISUAL=vim
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'
export PATH="$HOME/.local/bin:$PATH"

if [ -z "$HYPRLAND_INSTANCE_SIGNATURE" ] && command -v fish >/dev/null 2>&1; then
    exec fish
fi
