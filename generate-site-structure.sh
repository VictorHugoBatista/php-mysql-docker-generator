#!/bin/bash

if [ $# -lt 4 ]; then
	echo 'Informe título do projeto, virtual host, nome do banco e senha do root no comando'
	echo 'Exemplo: ./generate-site-structure.sh projeto-teste test.dev base-teste root'
	exit 1
fi
project_title=$1
virtual_host=$2
database_name=$3
root_password=$4

echo 'A seguinte estrutura será criada neste diretório:'
echo " - $project_title"
echo ' |- public (raíz do apache do docker)'
echo ' |- mysql (dados armazenados pelo mysql do docker)'
echo ' |- docker-compose.yml (gera os containeres do apache/php e do mysql e os relaciona)'
echo ''
echo 'Os seguintes containeres serão criados:'
echo " - $project_title-web (php/apache)"
echo "   - Virtual host: $virtual_host"
echo " - $project_title-db (mysql)"
echo "   - Nome do banco: $database_name"
echo "   - Senha do root: $root_password"
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

