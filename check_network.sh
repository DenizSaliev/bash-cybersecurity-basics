#!/bin/bash
while true; do
	clear
	echo "---------------------------------------------"
	echo "---------------  Menu de red  ---------------"
	echo "---------------------------------------------"
	echo "1-Mostrar direccion IP"
	echo "2-Mostrar puerta de enlace"
	echo "3-Mostrar DNS configurado"
	echo "4-Comprobar conectividad con google"
	echo "5-Comprobacion de resolucion DNS con google.com"
	echo "6-Mostrar puertos abiertos en local"
	echo "7-Salir"
	echo; read -p "Elija una opcion [1,2,3,4,5,6,7]: " op
	case $op in
		1)
			ip=$(ip a | grep -E "inet" | grep -E "brd" | cut -d " " -f6 | cut -d "/" -f1)
			echo;read -p "La ip del equipo es: $ip, Pulse ENTER para continuar ... " continuar
		;;
		2)
			pe=$(ip route | grep -Eo "via.*([0-9]{1,3}.){3}.[0-9]{1,3}" | cut -d " " -f2)
			echo;read -p "La puerta de enlace del equipo es: $pe, Pulse ENTER para continuar ... " continuar
		;;
		3)
			dns=$(cat /etc/resolv.conf | grep -Eo "([0-9]{1,3}.){3}.[0-9]{1,3}")
			echo;read -p "El dns configurado del equipo es: $dns, Pulse ENTER para continuar ... " continuar
		;;
		4)
			echo;echo "Verificando conectividad ..."
			if ping -c4 8.8.8.8 2&>/dev/null;then
				echo;echo "Hay conectividad con google"
			else
				echo;echo "No hay conectividad con google"
			fi
			echo;read -p "Pulse ENTER para continuar ... " continuar
		;;
		5)
			echo;echo "Verificando conectividad ..."
			nslookup google.com >/dev/null
			estado_dns=$?
			if [[ $estado_dns -eq 0 ]];then
				echo;echo "El DNS resuelve google.com"
			elif [[ $estado_dns -eq 1 ]];then
				echo;echo "El DNS no resuelve google.com"
			fi
			echo;read -p "Pulse ENTER para continuar ... " continuar
		;;
		6)
			puertos_abiertos=$(sudo ss -tulpn | grep -Ei "LISTEN" | awk '{print $5}' | grep -Eo "[0-9]{1,}$")
			echo;echo "Puertos abiertos: "
			numero="-1"
			for  i in $puertos_abiertos
			do
				if [[ $i -eq $numero ]];then
					repetido+=($i)
				else
					echo "$i"
				fi
				numero=$i
			done
			echo;read -p "Pulse ENTER para continuar ...  " continuar
		;;
		7)
			echo "Saliendo del script tecnico"
			exit 0
		;;
		*)
			echo;read -p "No ha seleccionado una opcion valida, Pulse ENTER para continuar ...  " continuar
		;;
	esac
done
