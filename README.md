# php-mysql-docker-generator
Gera automaticamente a estrutura para a criação de ambientes web PHP, Apache e MySQL com docker-compose.

## Requisitos
 * Sistema que permita a execução de [shell scripts](https://pt.wikipedia.org/wiki/Shell_script)
 * [Docker](https://www.docker.com/)
 * [Docker Compose](https://docs.docker.com/compose/)

## Instruções de uso
 * Copie os arquivos do repositório para o diretório raíz dos seus ambientes. Recomendado: **~/webroot**.
 A estrutura deve ser estar assim:
 ```
 - home
 |- USUARIO
   |- webroot
     |- docker-compose-sample.yml
     |- generate-site-structure.sh
 ```
 * Dê permissão de execução ao arquivo generate-site-structure.sh (no diretório **webroot**, execute o comando **chmod +x generate-site-structure.sh**).
 * Parâmetros obrigatórios:
    * Título do projeto, define o título do diretório raíz e o nome dos containeres;
    * Virtualhost apontando para o ambiente criado;
    * Nome do banco MySQL gerado automaticamente;
    * Senha do usuário root do MySQL.
 * Parâmetros opcionais:
    * Versão do PHP utilizada no ambiente. Padrão: **latest** (ver https://hub.docker.com/r/webgriffe/php-apache-base/tags/);
    * Raíz do Apache: Diretório à partir de **/var/html/www** (diretório **public** na raíz da estrutura de diretórios criada).
 * Exemplo:
    * **./generate-site-structure.sh projeto-teste test.dev base-teste root 5.6 public**
 * Ao executar o comando exbido acima, a seguinte estrutura será criada à partir do diretório atual (**você ainda pode prosseguir ou cancelar antes que a estrutura seja gerada**):
  ```
  - projeto-teste
  |- public (raíz do apache do docker)
  |- mysql (diretório de armazenamendo dos dados do mysql do docker)
  |- docker-compose.yml (arquivo já com as configurações iniciais)
  ```

## Dicas importantes
 * O MySQL deve ser referenciado pelo nome do container MySQL gerado automaticamente (definido pelo título do projeto seguido de **-db**) e não por localhost.
 * Os containeres podem ser parados executando o comando **docker-compose stop**, reiniciados com o comando **docker-compose restart** e inicializados com o comando **docker-compose up -d** na raíz da estrutura de diretórios gerada.
 * É possível verificar os containeres executando com o comando **docker ps**, verificar todos os containeres criados com **docker ps -a** e parar todos os containeres com **docker stop $(docker ps -q)**.
