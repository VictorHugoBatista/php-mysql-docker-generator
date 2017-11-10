script_file='/usr/bin/docker-gen-env'
if [ -e $script_file ]; then
	sudo rm $script_file
	echo 'Comando docker-gen-env desinstalado com sucesso!'
else
	echo 'Comando não instalado previamente!'
fi

