#!/bin/bash

if [ ! -e $1 ]
then
    echo "O arquivo não existe."
    exit 1
fi

# Criando o backup
cp $1 "$1_bkp"

echo "Backup criado: $(ls $1_bkp)" 

MENU="\n----------------------------
\n Menu de Opções
\n----------------------------
\n1 - Substituir uma palavra
\n2 - Remover linhas contendo uma palavra
\n3 - Adicionar um prefixo a todas as linhas
\n4 - Listar apenas as linhas que contêm uma palavra
\n5 - Sair
\n----------------------------"

echo -e $MENU

substituir_palavra(){
    read -p "Digite a palavra a ser substituída: " ANTIGA
    read -p "Digite a nova palavra: " NOVA
    sed -i "s/$ANTIGA/$NOVA/g" $1
    echo "Substituição concluída."    
}

remover_linhas(){
    read -p "Digite a palavra a ser removida: " PALAVRA
    sed -i "/$PALAVRA/d" $1
    echo "Linhas removidas."
}

adicionar_prefixo(){
    read -p "Digite o prefixo a ser incluído: " PREFIXO
    sed -i "s/^/$PREFIXO/g" $1
    echo "Prefixo adicionado."
}

listar_linhas(){
    read -p "Digite a palavra: " PALAVRA
    echo $(grep $PALAVRA $1)
}


while [ "$OPCAO" != "5" ]
do
    read -p "Selecione uma opção: " OPCAO

    case "$OPCAO" in
        "1")
            substituir_palavra $1
            echo -e $MENU
            ;;
        "2")
            remover_linhas $1
            echo -e $MENU
            ;;
        "3")
            adicionar_prefixo $1
            echo -e $MENU
            ;;
        "4")
            listar_linhas $1
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
