#!/bin/bash
help() {
    echo "help"
}
ERROR() {
    [ "$CMD" ] && echo "[ WARN ] Invalid command"

}

while true
do
    echo -n "ftp> "
    read CMD 
    case $CMD in
        'quit'|'bye') break ;;
        'help') HELP ;;
        *) ERROR ;;
    esac
done