#!/bin/bash


function install_terminator {
    if [[ ! $(command -v terminator) ]]; then
        install_package terminator
    fi
    cp -rf ${CURRENT_DIR}/Common/terminator ~/.config
    log_success "terminator already install!"
}

function install_zsh {
    if [[ ! $(command -v zsh) ]]; then
        install_package zsh curl
    fi
    echo "${PASSWORD}" |  chsh -s /bin/zsh
    if [[ ! -d ${HOME}/.zinit ]]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
    fi
    cp -rf ${CURRENT_DIR}/Common/zsh/.zshrc ${HOME}/
    cp -rf ${CURRENT_DIR}/Common/zsh/.p10k.zsh ${HOME}/
    log_success "zsh already install!"
}


function install_node {
    if [[ ! $(command -v n)  ]]; then
        curl -L https://git.io/n-install | bash
    fi
    log_success "n already install!"
    
    if [[ ! $(command -v node) ]]; then
        n install node
    fi
    log_success "node already install!"
}

function install_nvim {
    if [[ ! $(command -v nvim) ]]; then
        install_package curl git python-dev python3-dev software-properties-common
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        cp -rf ${CURRENT_DIR}/Common/nvim ~/.config
    fi
    log_success "nvm already install!"
}

function install_fonts {
    if [[ ! -d ${HOME}/.local/share/fonts/sarasa ]]; then
        mkdir -p ~/.local/share/fonts
        cp -fr ${CURRENT_DIR}/Common/fonts/sarasa ~/.local/share/fonts/
        pushd ~/.local/share/fonts
        mkfontscale && mkfontdir && fc-cache -fv
        popd
    fi
    log_success "sarasa font already install!"
}

