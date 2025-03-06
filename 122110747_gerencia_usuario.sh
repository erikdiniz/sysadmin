#!/bin/bash
# Erik Diniz Beserra - 122110747

menu="\nMenu:
\n
\n1 - Criar usuaŕio
\n2 - Excluir usuário
\n3 - Criar grupo
\n4 - Excluir grupo
\n5 - Adicionar usuário a grupo
\n6 - Remover usuário de grupo
\n7 - Listar usuários de um grupo
\n8 - Sair
"

# Verifica o resultado das operações, indicando sucesso ou erro
# Será utilizado em todas as funções para verificar se a operação foi concluída com sucesso
verificar_operacao(){
	if [ $? != 0 ]
	then
		echo "Erro: operação falhou"
	else
		echo "Sucesso: operação concluída"
	fi
}

# Função para criar usuario, recebe o nome e exibe uma mensagem de sucesso
criar_usuario(){
	sudo useradd $1
	verificar_operacao
}

# Recebe o nome do usuário e realiza a exclusão
excluir_usuario(){
	sudo userdel $1
	verificar_operacao
}

# Cria um grupo com o nome recebido
criar_grupo(){
	sudo groupadd $1
	verificar_operacao
}

# Exclui o grupo com o nome recebido
excluir_grupo(){
	sudo groupdel $1
	verificar_operacao
}

# adiciona um usuário a um grupo, solicita o nome do usuário e do grupo
adicionar_user_grupo(){
	sudo gpasswd -a $1 $2
	verificar_operacao
}

# remove um usuário de um grupo, solicita o nome do usuario e do grupo
remover_user_grupo(){
        sudo gpasswd -d $1 $2
        verificar_operacao
}

# lista usuários do grupo passado como parâmetro
listar_user_grupo(){
	username=$1
	echo "$(grep $username /etc/group)"
}

# loop while que continua exibindo o menu
while [ "$opcao" != "8" ]
do
	# Exibe o menu e recebe a opção do usuário
	echo -e $menu
	read -p "Escolha uma opção: " opcao

	case "$opcao" in

	# Chama a função criar_usuario
	"1")
	read -p "Digite o nome do usuário: " username
	criar_usuario $username
	;;

	# Chama a função excluir_usuario
	"2")
	read -p "Digite o nome do usuário a ser excluído: " username
	excluir_usuario $username
	;;

	# Chama a função criar_grupo passando o nome do grupo
	"3")
	read -p "Digite o nome do grupo: " grupo
	criar_grupo $grupo
	;;

	# Chama a função excluir_grupo e passa o nome do grupo
	"4")
	read -p "Digite o nome do grupo a ser excluído: " grupo
	excluir_grupo $grupo
	;;

	# Chama a função adiciona_user_grupo junto com os dois parâmetros necessários (username e groupname)
	"5")
	read -p "Digite o nome do usuário: " user
	read -p "Digite o nome do grupo: " grupo
	adicionar_user_grupo $user $grupo
	;;

	# Chama a função adiciona_user_grupo junto com os parâmetros (username e groupname)>
	"6")
	read -p "Digite o nome do usuário: " user
        read -p "Digite o nome do grupo: " grupo
        remover_user_grupo $user $grupo
	;;

	"7")
	read -p "Digite o nome do grupo: " grupo
	listar_user_grupo $grupo
	;;

	esac
done

echo "Execução finalizada. Até mais!"
