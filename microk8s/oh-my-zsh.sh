#!/bin/sh

apt-get update
apt-get upgrade -y
apt-get install zsh -y

# install oh my zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc

# load zsh
chsh -s /bin/zsh vagrant
zsh

# syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

# theme
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="sonicradish"/g' /home/vagrant/.zshrc

# auto suggesstion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/home/vagrant/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i 's/plugins=(git)/plugins=(zsh-autosuggestions git kubectl docker)/g' /home/vagrant/.zshrc
