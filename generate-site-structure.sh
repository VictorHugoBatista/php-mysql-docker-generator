#!/bin/bash

# Lê o título do ambiente (usado no título do diretório
# raíz da estrutura e nos títulos dos containeres) no
# primeiro parâmetro passado na execução do arquivo,
# se o parâmetro não for passado, o dado será pedido
# dentro do programa
if [ $# -lt 1 ]; then
	echo 'Informe o título do ambiente:'
	read project_title
else
	project_title=$1
fi

echo 'A seguinte estrutura será criada neste diretório:'
echo " - $project_title"
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
if [ -e $project_title ]; then
	echo "Um arquivo/diretório de nome $project_title já existe!"
	exit 1
fi

# Gera a estrutura de arquivos e concede permissão
mkdir $project_title
cd $project_title
mkdir public
mkdir mysql
touch docker-compose.yml
chmod -R 777 .

# Popula docker-compose e adiciona os dados fornecidos no programa
cat ../docker-compose-sample.yml > docker-compose.yml
sed -i "s/NOME-DO-PROJETO/$project_title/g" docker-compose.yml

# Exibe estrutura de arquivos
echo 'Estrutura criada com sucesso:'
ls -la

exit 0

