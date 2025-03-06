#!/bin/bash

menu="\nMenu
\n
\n1 - Listar processos
\n2 - Filtrar processos por nome
\n3 - Finalizar processo por PID
\n4 - Finalizar processos por nome
\n5 - Sair
"

# Lista os processos filtrando as informações importantes
listar_processos(){
	ps -eo pid,user,comm
}

# Fltra processos pelo nome
filtrar_processos(){
	ps -eo pid,user,comm | grep $1
}

# finaliza processo pelo pid
finalizar_pid(){
	kill $1
}

# finaliza processo pelo nome
finalizar_nome(){
	killall $1
}

while [ "$opcao" != "5" ]
do
	echo -e $menu
	read -p "Escolha uma opção: " opcao

	case "$opcao" in

	"1")
	listar_processos
	;;

	"2")
	read -p "Digite o nome do processo: " processo
	filtrar_processos $processo
	;;

	"3")
	read -p "Digite o PID: " pid
	finalizar_pid $pid
	;;

	"4")
	read -p "Digite o nome do processo: " nome
	finalizar_nome $nome
	;;
	esac
done

echo "Execução finalizada. Até mais!"
