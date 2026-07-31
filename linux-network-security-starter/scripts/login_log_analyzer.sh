#!/bin/bash
clear

fallos_inicio_sesion=$(cat /var/log/auth.log | grep -aEi "gdm-password.*authentication failure")
user_inicio_sesion=$(cat /var/log/auth.log | grep -aEi "gdm-password.*authentication failure" | grep -aEio "user=[a-z]*" | cut -d "=" -f2 | sort -u)
num_user_inicio_sesion=$(cat /var/log/auth.log | grep -aEi "gdm-password.*authentication failure" | wc -l)

fallos_sudo=$(cat /var/log/auth.log | grep -aEi "password check failed for user")
user_fallos_sudo=$(cat /var/log/auth.log | grep -aEi "password check failed for user" | grep -aEi "user .*([a-z])" | cut -d "(" -f 2 | cut -d ")" -f 1 | sort -u)
num_fallos_sudo=$(cat /var/log/auth.log | grep -aEi "password check failed for user" | wc -l)

fallos_ssh=$(cat /var/log/auth.log | grep -aEi "failed password for.*from.*")
user_fallos_ssh=$(cat /var/log/auth.log | grep -aEi "failed password for.*from.*" | grep -aEoi "for [a-z]{1,}" | cut -d " " -f 2 | sort -u)
ips_afectadas=$(cat /var/log/auth.log | grep -aEi "failed password for.*from.*" | cut -d " " -f 9 | sort -u)
num_fallos_ssh=$(cat /var/log/auth.log | grep -aEi "failed password for.*from.*" | wc -l)

fallos_juntos=$(echo -e "$fallos_inicio_sesion\n$fallos_sudo\n$fallos_ssh")
num_intentos=$(echo -e "$fallos_inicio_sesion\n$fallos_sudo\n$fallos_ssh" | wc -l)

echo "--------------------------------------------------------------------------------------------------------"
echo "-------------------------------------------LOGIN_LOG_ANALYZER-------------------------------------------"
echo "--------------------------------------------------------------------------------------------------------"
echo ""
echo "El número total de intentos fallidos de login es: $num_intentos"
echo ""
echo "----------------------------------------"
echo "--------CONSOLA DE ACCESO AL S.O.-------"
echo "----------------------------------------"
echo "Número de intentos fallidos: $num_user_inicio_sesion"
echo ""
echo -e "Usuarios afectados: $user_inicio_sesion"
echo ""
echo "--------------------------------------------"
echo "--------FALLOS DE EJECUCIÓN CON ROOT--------"
echo "--------------------------------------------"
echo "Número de intentos fallidos: $num_fallos_sudo"
echo ""
echo -e "Usuarios afectados (desde donde se intentó escalar privilegios):\n$user_fallos_sudo"
echo ""
echo "--------------------------------------------"
echo "--------FALLOS DE ACCESO POR SSH------------"
echo "--------------------------------------------"
echo "Número de intentos fallidos: $num_fallos_ssh"
echo ""
echo -e "Usuarios afectados:\n$user_fallos_ssh"
echo ""
echo -e "IPs afectadas:\n$ips_afectadas"
