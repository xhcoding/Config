#!/usr/bin/env bash
# Filename: bootstrap.sh
# Description: bootstrap.sh
# Author: xhcoding <xhcoding@163.com>
# Copyright (C) 2020, xhcoding, all right reserved
# Created: 2020-07-28 12:13
# Version: 0.1
# Last-Update: 2020-07-28 12:13 by xhcoding
#
# Change log:
# 2020-07-28
#       * first commit
#

# 进入配置文件根目录
cd "$(dirname "$0")"

# 配置文件根目录
DOTFILES_ROOT=$(pwd -P)/linux


set -e

. scripts/functions.sh

function update_config {
    info "update personal config"
    info "update zsh config"
    copy_file ~/.zshrc $DOTFILES_ROOT/.zshrc
}

function install_config {
    info "install personal config"
    info "install zsh config"
    copy_file $DOTFILES_ROOT/.zshrc ~/.zshrc
}


function display_usage {
    echo "./bootstrap.sh -f function [args]"
    echo "functions:  "
    echo "1. update_config: update personal config."
    echo "2. install_config: update personal config."

}

if [ "$1" == "-h" -o "$1" == "--help" ] ; then
    display_usage
elif [ "$1" == "-f" -o "$1" == "--function" ]; then
    $2 $3
fi
