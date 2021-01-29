#!/bin/bash

function update_software_source {
    sudo apt update
}

function install_package {
    local packages=$*
    log_info "Start install ${packages}"
    sudo apt install -y ${packages}
}

function install_docker {
    if [[ ! $(command -v docker) ]]; then
        install_package zsh curl
        install_package apt-transport-https ca-certificates curl python-software-properties software-properties-common
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
        sudo apt install docker-ce docker-compose
        sudo gpasswd -a ${USER} docker
    fi
    
}