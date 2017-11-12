#!/bin/bash

if [ $# -lt 4 ]; then
	echo 'Informe os parâmetros:'
	echo ' - título do projeto'
	echo ' - virtual host'
	echo ' - nome do banco'
	echo ' - senha do root'
        echo ' - versão do php (opcional)'
	echo ' - raíz do apache à partir de /var/html/www (opcional)'
	echo ''
	echo 'Exemplo: ./generate-site-structure.sh projeto-teste test.dev base-teste root 5.6 public'
	echo 'Ver mais em https://github.com/VictorHugoBatista/php-mysql-docker-generator'
	exit 1
fi

project_title=$1
virtual_host=$2
database_name=$3
root_password=$4
php_version=`[ $5 ] && echo $5 || echo 'latest'`
apache_root=`[ $6 ] && echo "$6" || echo ''`

echo 'A seguinte estrutura será criada neste diretório:'
echo " - $project_title"
echo ' |- public (raíz do apache do docker)'
echo ' |- mysql (dados armazenados pelo mysql do docker)'
echo ' |- docker-compose.yml (gera os containeres do apache/php e do mysql e os relaciona)'
echo ''
echo 'Os seguintes containeres serão criados:'
echo " - $project_title-web (php/apache)"
echo "   - PHP $php_version"
echo "   - Diretório raíz do apache: /var/www/html/$apache_root"
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

# Popula docker-compose e adiciona os dados fornecidos no programa
cat ../docker-compose-sample.yml > docker-compose.yml
sed -i "s/NOME-DO-PROJETO/$project_title/g" docker-compose.yml
sed -i "s/VIRTUAL-HOST/$virtual_host/g" docker-compose.yml
sed -i "s/BANCO/$database_name/g" docker-compose.yml
sed -i "s/SENHA-ROOT/$root_password/g" docker-compose.yml
sed -i "s/PHP-VERSION/$php_version/g" docker-compose.yml
sed -i "s/APACHE-ROOT/$apache_root/g" docker-compose.yml

# Exibe estrutura de arquivos
echo 'Estrutura criada com sucesso:'
ls -la
echo ''

if [ $(docker ps -a -q -f name="$project_title-web") ] || [ $(docker ps -a -q -f name="$project_title-db") ]; then
	echo 'Já existem containeres com o mesmo nome da estrutura criada!'
	exit 1
fi

chmod -R 777 .
docker-compose up -d

exit 0

