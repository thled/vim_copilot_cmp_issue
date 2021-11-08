# PoC: nvim-cmp incompatible with Copilot.vim

**UPDATE:**
This is the fixed version where the Copilot.vim configurations are loaded at start-up and not in the `after` module.

Minimal Neovim setup to reproduce the <kbd>Tab</kbd> issue while using the plugins [nvim-cmp][cmp] and [Copilot.vim][copilot].

Linked issue: <https://github.com/hrsh7th/nvim-cmp/issues/459>

## Requirements

- [Docker][docker]

## Installation

1. Clone this repository:

    ```shell
    git clone git@github.com:thled/vim_copilot_cmp_issue.git
    ```

1. Change to project directory:

    ```shell
    cd vim_copilot_cmp_issue
    ```

1. Build image

    ```shell
    docker build -t vim_copilot_cmp_issue .
    ```

## Usage

```shell
docker run --rm -it vim_copilot_cmp_issue
```

## Reproduce issue

### Steps

1. Run container.
1. Create a file.
1. Change to Insert mode.
1. Press <kbd>Tab</kbd>.

### Expected behaviour

It inserts a tab indent.

### Actual behaviour

It inserts `<Plug>(cmp.utils.keymap.recursive:      )`.

### Showcase

<p align="center">
  <img width="960" src="https://raw.githubusercontent.com/thled/vim_copilot_cmp_issue/master/vim_copilot_cmp_issue.svg">
</p>

[docker]: https://docs.docker.com/install
[cmp]: https://github.com/hrsh7th/nvim-cmp
[copilot]: https://github.com/github/copilot.vim

