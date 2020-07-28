#!/usr/bin/env bash
# Filename: functions.sh
# Description: some tool function
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

# 几个信息显示函数

function info {
    printf "\r  [ \033[00;34mINFO\033[0m ] $1\n"
}


function success {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

function fail {
    printf "\r\033[2K  [ \033[0;31mFAIL\033[0m ] $1\n"
    exit -1
}


function user {
    printf "\r  [ \033[0;33mUSER\033[0m ] $1"
}

# 链接文件
# $1: 源文件
# $2: 目标文件
# $3: 目标文件存在时的操作
#   s: skip all
#   o: overwrite
#   b: backup
#   a/empty: ask
function link_file {
    local src=$1 dst=$2 action=$3
    local overwrite= backup= skip=
    local res=

    if [ -f "$dst" -o -d "$dst" -o -L "dst" ] ; then
        if [ "$action" == "s" ] ; then
            skip=true
        elif [ "$action" == "o" ]; then
            overwrite=true
        elif [ "$action" == "b" ]; then
            backup=true
        else
            user "File already exists: \033[31m $dst \033[0m , what do you want to do?\n[s]kip (default),\n[o]verwrite,\n[b]ackup,\nYour choose: "
            read -n 1 action

            case "$action" in
                o )
                    overwrite=true;;
                b )
                    backup=true;;
                s )
                    skip=true;;
                * )
                    skip=true;;
            esac

        fi

    fi


    if [ "$overwrite" == "true" ] ; then
        rm -rf "$dst"
        success "remove $dst"
    fi

    if [ "$backup" == "true" ] ; then
        mv "$dst" "${dst}.backup"
        success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ] ; then
        success "skipped $src"
    fi
    if [ "$skip" != "true" ] ; then
        ln -s "$1" "$2"
        success "linked $1 to $2"
    fi
}

# 复制文件
# $1: 源文件
# $2: 目标文件
# $3: 目标文件存在时的操作
#   s: skip all
#   o: overwrite
#   b: backup
#   a/empty: ask
function copy_file {
    local src=$1 dst=$2 action=$3
    local overwrite= backup= skip=
    local res=

    if [ -f "$dst" -o -d "$dst" -o -L "dst" ] ; then
        if [ "$action" == "s" ] ; then
            skip=true
        elif [ "$action" == "o" ]; then
            overwrite=true
        elif [ "$action" == "b" ]; then
            backup=true
        else
            user "\nFile already exists: \033[31m $dst \033[0m  , what do you want to do?\n[s]kip (default),\n[o]verwrite,\n[b]ackup,\nYour choose: "
            read -n 1 action

            case "$action" in
                o )
                    overwrite=true;;
                b )
                    backup=true;;
                s )
                    skip=true;;
                * )
                    skip=true;;
            esac

        fi

    fi


    if [ "$overwrite" == "true" ] ; then
        rm -rf "$dst"
        success "remove $dst"
    fi

    if [ "$backup" == "true" ] ; then
        if [ -d "${dst}.backup" -o -f "${dst}.backup" -o -L "${dst}.backup" ] ; then
            rm -rf "${dst}.backup"
            success "rm old backup"
        fi
        mv "$dst" "${dst}.backup"
        success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ] ; then
        success "skipped $src"
    fi

    if [ "$skip" != "true" ] ; then
        cp -R "$1" "$2"
        success "copyed $1 to $2"
    fi
}

# 安装 package
# $1: 包名
function install_package {
    local install_cmd=""
    if grep "deepin" /etc/os-release > /dev/null ; then
        install_cmd="apt install ";
    fi
    $install_cmd $1
}
