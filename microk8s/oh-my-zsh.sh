#!/bin/sh

apt-get install zsh -y

# install oh my zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh
cp /root/.oh-my-zsh/templates/zshrc.zsh-template /root/.zshrc

# load zsh
chsh -s /bin/zsh vagrant
zsh

# syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "/root/.zsh-syntax-highlighting" --depth 1
echo "source /root/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "/root/.zshrc"

# theme
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="sonicradish"/g' /root/.zshrc

# auto suggesstion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/root/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i 's/plugins=(git)/plugins=(zsh-autosuggestions git kubectl docker)/g' /root/.zshrc

# kubectl aliases
cp /root/.kubectl_aliases /root/.kubectl_aliases
echo "[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases" >> "/root/.zshrc"
