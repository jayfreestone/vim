# (Neo) Vim Setup

My current Vim setup, now with a focus on the [Neovim](https://neovim.io) fork.

Setup is as simple as:

    ln -s ~/.vim ~/.config/nvim
    ln -s ~/.vim/vimrc ~/.vim/init.vim

The [Python 3](https://neovim.io/doc/user/nvim_python.html) module will need to be installed for [deoplete](https://github.com/Shougo/deoplete.nvim) and [fzf](https://github.com/junegunn/fzf) for fuzzy-finding.

Everything else can be installed with `:PlugInstall`
