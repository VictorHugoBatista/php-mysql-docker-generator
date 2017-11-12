bin_path='/usr/bin'
script_name='docker-gen-env'
script_file="$bin_path/$script_name"

if [ -e $script_file ]; then
	echo "O arquivo $script_name será removido do diretório $bin_path"
else
	echo "O arquivo $script_name será adicionado ao diretório $bin_path"
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
	echo "Comando $script_name desinstalado com sucesso!"
else
	sudo cp docker-gen-env.sh $script_file
	sudo chmod +x $script_file
	echo "Comando $script_name instalado com sucesso!"
fi

