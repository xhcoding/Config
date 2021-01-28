#!/bin/bash

function update_software_source {
    sudo apt update
}

function install_package {
    local packages=$*
    log_info "Start install ${packages}"
    sudo apt install -y ${packages}
}

