#!/bin/bash

MENU="\n----------------------------
\n      Menu de Opções        
\n----------------------------
\n1 - Listar ocorrências de um erro
\n2 - Remover linhas irrelevantes
\n3 - Contar ocorrências de um erro
\n4 - Extrair as 10 últimas linhas do log
\n5 - Sair
\n----------------------------"

if [ ! -e $1 ]
then
    echo "O arquivo não existe."
    exit 1
fi

#Criando o backup
cp $1 "$1_bkp"

echo "Backup criado: $(ls $1_bkp)"

echo -e $MENU

remover_linhas(){
    read -p "Digite a palavra da linha a ser removida: " PALAVRA
    sed -i "/$PALAVRA/d" $1
    echo "Linhas removidas."
}

listar_ocorrencias(){
    read -p "Digite a palavrachave do erro a ser buscado: " ERRO
    echo "Ocorrências de $ERRO:"
    echo $(grep $ERRO $1)
}

exibir_linhas(){
    tail $1
}

contar_ocorrencias(){
    read -p "Digite o erro: " ERRO
    echo $(grep -c $ERRO $1)
}

while [ "$OPCAO" != "5" ]
do
    read -p "Selecione uma opção: " OPCAO

    case "$OPCAO" in
        "1")
            listar_ocorrencias $1
            echo -e $MENU
            ;;
        "2")
            remover_linhas $1
            echo -e $MENU
            ;;
        "3")
            contar_ocorrencias $1
            echo -e $MENU
            ;;
        "4")
            exibir_linhas $1
            echo -e $MENU
            ;;
        "5")
            echo "Execução do script finalizada."
            exit 1
            ;;
        *)
            echo -e $MENU
    esac
done

