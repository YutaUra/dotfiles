# dotfilesのクローン
git clone https://github.com/YutaUra/dotfiles.git

# Homebrewのインストール
echo "\n1. Homebrew のインストールを開始します\n"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew bundle --file=~/dotfiles/Brewfile

# Preztoのインストール
echo "\n2. Prezto のインストールを開始します\n"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
# .zpreztorcの設定コピー
rm ~/.zpreztorc
ln -s ~/dotfiles/.zpreztorc ~/.zpreztorc


# ghの設定
echo "\n3. ghの設定を開始します\n"
git config --global user.name "YutaUra"
git config --global user.email "yuuta3594@outlook.jp"
echo "\nghでログインします。\n"
gh auth login
echo "sshでgithubに接続できるか確認"
ssh -T git@github.com

# anyenvの設定
echo "\n4. anyenvの設定を開始します\n"
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
echo "\nanyenvの設定を完了させるため、以下の指示に従ってください\n"
eval "$(anyenv init -)"