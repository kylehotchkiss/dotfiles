## Getting Started

First, quit all open instances of Visual Studio code, then run the following in Terminal:

```
mv ~/Library/Application\ Support/Code/User/settings.json ~/.dotfiles/VSCode/
mv ~/Library/Application\ Support/Code/User/keybindings.json ~/.dotfiles/VSCode/
mv ~/Library/Application\ Support/Code/User/snippets/ ~/.dotfiles/VSCode/

ln -s ~/.dotfiles/VSCode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/.dotfiles/VSCode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/.dotfiles/VSCode/snippets/ ~/Library/Application\ Support/Code/User
```

## Read More
https://pawelgrzybek.com/sync-vscode-settings-and-snippets-via-dotfiles-on-github/