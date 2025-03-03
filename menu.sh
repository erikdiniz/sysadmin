#!/bin/bash

menu="\nEscolha uma opção:
\n1 - Data atual
\n2 - Listar arquivos
\n3 - Uso de disco
\n4 - Sair\n"

echo -e $menu

while [ "$opcao" != "4" ]
do
    read -p "Opção: " opcao 

    case $opcao in
        "1")
        echo "A data atual é: $(date)"
        echo -e $menu
        ;;
        "2")
        echo -e "Os arquivos do diretório atual: $(pwd)\n"
        ls
        echo -e $menu
        ;;
        "3")
        top
        echo -e $menu
        ;;
        "4")
        echo "Execução encerrada."
        exit -1
        ;;
    esac
done