git init --bare $HOME/.cfg
function config {& git --git-dir=$HOME/.cfg/ --work-tree=$HOME $args }
config config --local status.showUntrackedFiles no

Write-Host "function config { git --git-dir=`$HOME/.cfg/ --work-tree=`$HOME $args }"