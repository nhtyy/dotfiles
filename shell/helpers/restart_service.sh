restart_unit() {
    sudo systemctl restart "$1"
}

restart_unit "$1"