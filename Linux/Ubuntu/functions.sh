#!/bin/bash

function update_software_source {
    if [[ $(diff /etc/apt/sources.list ${CURRENT_DIR}/Ubuntu/sources.list) ]]; then
        sudo cp -f ${CURRENT_DIR}/Ubuntu/sources.list /etc/apt/sources.list
        sudo sed -i s/CODENAME/$(lsb_release -cs)/g /etc/apt/sources.list
        log_info "Update software source finished!"
    else
        log_info "Software source is newly!"   
    fi
    sudo apt update
}

function install_package {
    readonly local packages=$*
    log_info "Start install ${packages}"
    sudo apt install -y ${packages}
}

function install_vscode {
    if [[ ! $(command -v code) ]]; then
        log_info "Start install vscode"
        sudo snap install code --classic
    else
        log_success "vscode already install !"
    fi
}
