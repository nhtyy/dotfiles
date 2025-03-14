set -e

if [[ $SHELL == *"zsh"* ]]; then
    echo "zsh"
    echo "assuming you have a ~/.zshrc file @ $HOME/.zshrc"
else
    echo "Unknown shell type $SHELL"
    exit 1
fi

echo "adding useful commands to $HOME/.zshrc"

mkdir -p $HOME/.nhtyy-helpers/bin
cp -r shell/helpers/* $HOME/.nhtyy-helpers/bin

echo "Amending PATH to include $HOME/.nhtyy-helpers/bin"
echo "export PATH=$HOME/.nhtyy-helpers/bin:$PATH" >> $HOME/.zshrc