#!/bin/bash


check_if_exists() {
    if ! [ -x "$(command -v $1)" ]; then
        echo "Error: $1 must be installed." >&2
        exit 1
    fi
}

install_language_servers() {
    required_programs="yay npm pip"

    for program in $required_programs
    do
        check_if_exists $program
    done

    pip install cmakelang
    npm install -g dockerfile-language-server-nodejs
    npm install -g jsonlint
    yay -S bash-language-server
    yay -S aur/ltex-ls-bin
    yay -S typescript-language-server
    yay -S aur/vscode-langservers-extracted
    yay -S clang
    yay -S lua-language-server
    yay -S python-lsp-server
    yay -S eslint_d
    yay -S aur/checkmake
    yay -S aur/prettierd
    yay -S lua-format
    yay -S fixjson
    yay -S aur/beautysh
    yay -S yamllint
    yay -S stylelint
    yay -S ruff
    yay -S editorconfig-checker
    yay -S aur/dotenv-linter
    yay -S cppcheck
}

