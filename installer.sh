script_file='/usr/bin/docker-gen-env'
if [ -e $script_file ]; then
	sudo rm $script_file
	echo 'Comando docker-gen-env desinstalado com sucesso!'
else
	sudo cp docker-gen-env.sh $script_file
	sudo chmod +x $script_file
	echo 'Comando instalado com sucesso!'
fi

