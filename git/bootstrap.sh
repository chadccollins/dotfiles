#######
# Description
# Bootstraps git config files in bash
#
#
# Ensures $DOTFILES_BASE/git
#    $HOME/.gitconfig -> $dotfiles/git/gitconfig
#    $HOME/.gitconfig_os -> $dotfiles/git/gitconfig_os_windows
#    $HOME/.gitignore -> $dotfiles/git/gitignore
#    $HOME/.gitattributes -> $dotfiles/git/gitattributes
#
######

# symlink $dotfiles/gitconfig to /etc/gitconfig
ln -f ./gitconfig /etc/gitconfig
