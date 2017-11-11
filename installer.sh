script_file='/usr/bin/docker-gen-env'

if [ -e $script_file ]; then
	echo 'O arquivo docker-gen-env será removido ao diretório /usr/bin'
else
	echo 'O arquivo docker-gen-env será adicionado ao diretório /usr/bin'
fi
echo 'Digite "s" para prosseguir ou "n" para cancelar:'


# Pede confirmação sobre a estrutura à ser criada
continue_process=''
while [ "$continue_process" = '' ] || [ "$continue_process" != 's' ] && [ "$continue_process" != 'n' ]; do
	echo 'Pressione "s" ou "n" para prosseguir:'
	read continue_process
done
# Para a execução caso a opção selecionada foi 'n'
if [ "$continue_process" = 'n' ]; then
	echo 'A operação foi cancelada!'
	exit 0
fi

if [ -e $script_file ]; then
	sudo rm $script_file
	echo 'Comando docker-gen-env desinstalado com sucesso!'
else
	sudo cp docker-gen-env.sh $script_file
	sudo chmod +x $script_file
	echo 'Comando docker-gen-env instalado com sucesso!'
fi

