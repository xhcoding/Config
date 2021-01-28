#!/bin/bash


function install_deepin_terminal {
    if [[ ! $(command -v deepin-terminal) ]]; then
        install_package deepin-terminal
    fi
    cp -rf ${CURRENT_DIR}/Common/deepin-terminal/ ~/.config/deepin/
    log_success "deepin_terminal already install!"
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
        install_package neovim curl git python-dev python3-dev software-properties-common
        
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    fi
    cp -rf ${CURRENT_DIR}/Common/nvim ~/.config
    log_success "nvim already install!"
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

