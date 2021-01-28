#!/bin/bash

set -e

readonly CURRENT_DIR="$( cd "$( dirname "$0"  )" && pwd  )"

# import log functions

source ${CURRENT_DIR}/Functions/log.sh

readonly RELEASE_ID=$(lsb_release -is)

log_info "Hello, This is ${RELEASE_ID}, load ${RELEASE_ID}'s functions!"

source ${CURRENT_DIR}/${RELEASE_ID}/functions.sh

update_software_source

source ${CURRENT_DIR}/Common/functions.sh

install_deepin_terminal

install_zsh

install_node

install_nvim

install_fonts
