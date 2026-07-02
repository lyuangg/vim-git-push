# vim-git-push

Smart git push with auto upstream setup. Pushes directly without opening a terminal.

## Install

vim-plug:
```vim
Plug 'lyuangg/vim-git-push'
```

lazy.nvim:
```lua
{ 'lyuangg/vim-git-push' }
```

## Usage

```vim
:GitPush          " 命令模式
<Leader>gP        " 快捷键
```

- Push 成功：底部状态栏显示结果
- 远程无分支：弹出确认框，自动执行 `git push -u origin <branch>`
- Push 失败：状态栏显示错误信息
