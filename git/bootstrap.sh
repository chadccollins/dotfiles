#######
# Description
# Bootstraps git config files
#
#
# Ensures $DOTFILES_BASE/git
#    $HOME/.gitconfig -> $dotfiles/git/gitconfig
#    $HOME/.gitconfig_os -> $dotfiles/git/gitconfig_os_osx
#    $HOME/.gitignore -> $dotfiles/git/gitignore
#    $HOME/.gitattributes -> $dotfiles/git/gitattributes
#
######

# symlink $dotfiles/gitconfig to /etc/gitconfig
echo "Linking gitconfig."
ln -f ./gitconfig /etc/gitconfig

echo "Linking gitconfig_os"
ln -f ./gitconfig_os_osx /etc/gitconfig_os

echo "Linking gitignore"
ln -f ./gitignore /etc/gitignore

echo "Linking gitattributes"
ln -f ./gitattributes /etc/gitattributes

