git init --bare "$HOME/.cfg"
function config {& git --git-dir="$HOME/.cfg/" --work-tree="$HOME" $args }

config remote add origin "https://github.com/NeilCross/dotfiles-win.git"
config pull origin master
config reset --hard origin/master
config config --local status.showUntrackedFiles no

install-module posh-git -Scope CurrentUser

Write-Host "function config { git --git-dir="`$HOME/.cfg/" --work-tree="`$HOME" $args }"
