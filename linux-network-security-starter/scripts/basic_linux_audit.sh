#!/bin/bash
clear
echo "-------------------------------------"
echo "----------BASIC-LINUX-AUDIT----------"
echo "-------------------------------------"
nombredeequipo=$(hostname)
echo;echo "El nombre del equipo es:$nombredeequipo"
usuarioactual=$(whoami)
echo;echo "El usuario actual es:$usuarioactual"
for i in $(cat /etc/passwd | cut -d ":" -f 1,3);do
	usu=$(echo $i | cut -d ":" -f 1)
	num=$(echo $i | cut -d ":" -f 2)
	if [[ "$num" -ge 1000 ]] && [[ "$usu" != "nobody" ]];then
		usuarioscreadosporelusuario+="\t\t$usu  (UID: $num) \n"

	else
		usuariosquevienenyacreados+="\t\t$usu  (UID: $num) \n"
	fi
done
echo; echo "Usuarios del sistema:"
echo;echo "	- Creados por el usuario:"
echo -e "$usuarioscreadosporelusuario"
echo;echo "	- Usuarios por defecto de linux:"
echo -e "$usuariosquevienenyacreados"
for i in $(cat /etc/passwd | cut -d ":" -f 1,7);do
	usu=$(echo $i | cut -d ":" -f 1)
	consola=$(echo $i | cut -d ":" -f 2)
	if [[ "$consola" = "/usr/sbin/nologin" ]] || [[ "$consola" = "/bin/false" ]];then
		usuariossinnshellinteractiva+="\t$usu\n"

	else
		usuariosconnshellinteractiva+="\t$usu\n"
	fi
done
echo; echo "Usuarios con shell interactiva:"
echo -e "$usuariosconnshellinteractiva"
echo "Procesos activos relevantes:"
procesosrelevantes=$(ps -eo user,pid,%cpu,%mem,comm --sort=-%cpu | head -n 6)
echo;echo "$procesosrelevantes"
echo;echo "Servicios activos:"
serviciosactivos=$(systemctl list-units  --type=service --state=running | cut -d " " -f 3 | grep -Eiv "unit" | grep -Ev " ")
echo;echo "$serviciosactivos" | grep -n ""
echo;echo "Intentos de login:";echo;tail /var/log/auth.log
archivosconpermisosdeescritura=$(ls -la | cut -d " " -f 1,10 | grep -Ei "^-.*w")
echo;echo "Archivos del directorio actual con permisos de escritura:"
echo "$archivosconpermisosdeescritura"




