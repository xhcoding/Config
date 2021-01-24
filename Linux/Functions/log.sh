#!/bin/bash

# log functions

function log_info {
    printf "\r  [ \033[00;34mINFO\033[0m ] $1\n"
}

function log_user {
    printf "\r  [ \033[0;33mUSER\033[0m ] $1"
}

function log_success {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

function log_fail {
    printf "\r\033[2K  [ \033[0;31mFAIL\033[0m ] $1\n"
    echo ''
    exit
}
