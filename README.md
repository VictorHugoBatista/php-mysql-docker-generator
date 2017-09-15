# php-mysql-docker-generator
Gera automaticamente a estrutura para a criação de aplicações web com PHP e MySQL com docker-compose

## Requisitos
 * Sistema que permita a execução de [shell scripts](https://pt.wikipedia.org/wiki/Shell_script)
 * [Docker](https://www.docker.com/)
 * [Docker Compose](https://docs.docker.com/compose/)

## Instruções de uso
 * Copie os arquivos do repositório para o diretório raíz dos seus sistemas. Recomendado: **/home/USUARIO/webroot** (caminho também descrito como **~/webroot**).
 A estrutura deve ser estar assim:
 ```
 - home
 |- USUARIO
   |- webroot
     |- docker-compose-sample.yml
     |- generate-site-structure.sh
 ```
 * Dê permissão de execição ao arquivo generate-site-structure.sh (o diretório **webroot**, execute o comando **chmod +x generate-site-structure.sh**).
 * Execute o arquivo shell para gerar a estrutura inicial de diretórios (**./generate-site-structure.sh**).
  * Um parâmetro pode ser passado na execução, será o nome do diretório raíz gerado. Caso o parâmetro não seja fornecido, o dado será pedido na execução do programa.
  * Ao executar o comando **./generate-site-structure.sh projeto_teste**, a seguinte estrutura será criada à partir do diretório atual (**você ainda pode prosseguir ou cancelar antes que a estrutura seja gerada**):
  ```
  - projeto_teste
  |- public (raíz do apache do docker)
  |- mysql (diretório de armazenamendo dos dados do mysql do docker)
  |- docker-compose.yml (arquivo já com as configurações iniciais)
  ```
 * Substitua os tokens **NOME-DO-PROJETO**, **BANCO**, **SENHA-ROOT** e **VIRTUAL-HOST**.
   * **NOME-DO-PROJETO**: Define a forma com que os containeres serão nomeados;
   * **BANCO**: Define o nome do banco gerado no MySQL;
   * **SENHA-ROOT**: Define a senha do root da instalação do MySql gerada no docker;
   * **VIRTUAL-HOST**: Define o virtualhost do container do apache (o virtualhost deve estar previamente configurado no arquivo de hosts do seu sistema operacional).
 * Execute o comando **[sudo docker-compose up -d](https://docs.docker.com/compose/reference/up/)**. Na primeira execução, as imagens serão baixadas, logo após, o site estará disponível em [http://localhost](http://localhost) porta 80.
 * Por fim, o MySQL deve ser referenciado pelo nome do container (definido como **NOME-DO-PROJETO-db**) e não por localhost.
