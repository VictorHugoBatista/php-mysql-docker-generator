#!/bin/bash

# Lê o nome do diretório raíz do primeiro parâmetro
# passado na execução do arquivo, se o parâmetro não
# for passado, o dado será pedido dentro do programa
if [ $# -lt 1 ]; then
	echo 'Informe o nome do diretório raíz:'
	read dir_root
else
	dir_root=$1
fi

echo 'A seguinte estrutura será criada neste diretório:'
echo " - $dir_root"
echo ' |- public (raíz do apache do docker)'
echo ' |- mysql (dados armazenados pelo mysql do docker)'
echo ' |- docker-compose.yml (gera os containeres do apache/php e do mysql e os relaciona)'
echo ''

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

# Verifica a existência de um arquivo com o nome
# sugerido para ser o diretório raíz do site. Se
# sim, para o programa com status 1.
if [ -e $dir_root ]; then
	echo "Um arquivo/diretório de nome $dir_root já existe!"
	exit 1
fi

# Gera a estrutura de arquivos e concede permissão
mkdir $dir_root
cd $dir_root
mkdir public
mkdir mysql
touch docker-compose.yml
cd ..
chmod -R 777 $dir_root

cat docker-compose-sample.yml > $dir_root/docker-compose.yml

# Exibe estrutura de arquivos
echo 'Estrutura criada com sucesso:'
ls -la $dir_root

exit 0

