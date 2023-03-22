Pimp your shell
===============



.. code-block:: shell

  $ chsh -s $(which zsh)

  $ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  $ git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

  $ sed -re 's/^(ZSH_THEME=)"robbyrussell"/\1"powerlevel10k\/powerlevel10k"/' -i ~/.zshrc
  $ source ~/.zshrc

  $ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  $ git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
