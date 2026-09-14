#!/bin/bash
# ==============================================================================
# Script: login_log_analyzer.sh
# Autor: Deniz Shoray Saliev Nikolov
# Descripción: Analizador básico de intentos fallidos de autenticación en Linux.
#              Revisa eventos de entorno gráfico (gdm), sudo y accesos por SSH.
# Requisitos: Permisos de lectura sobre /var/log/auth.log (ejecutar con sudo).
# ==============================================================================

clear

LOG_FILE="/var/log/auth.log"

# --- 1. Comprobación de requisitos y permisos ---
if [ ! -f "$LOG_FILE" ]; then
    echo "[ERROR] El archivo de registro $LOG_FILE no existe en este sistema."
    echo "Asegúrate de que estás ejecutando el script en una distribución basada en Debian/Ubuntu."
    exit 1
fi

if [ ! -r "$LOG_FILE" ]; then
    echo "[ERROR] No tienes permisos suficientes para leer $LOG_FILE."
    echo "Por razones de seguridad, debes ejecutar este script con privilegios de administrador:"
    echo "Uso: sudo $0"
    exit 1
fi

# --- 2. Funciones de extracción de datos ---

analizar_accesos_locales() {
    # Filtra eventos de fallo en la pantalla de bloqueo o inicio gráfico (GDM)
    local fallos_gdm
    fallos_gdm=$(grep -aEi "gdm-password.*authentication failure" "$LOG_FILE")
    
    local num_gdm
    num_gdm=$(echo -n "$fallos_gdm" | grep -c "^")
    [ -z "$fallos_gdm" ] && num_gdm=0

    local users_gdm
    users_gdm=$(echo "$fallos_gdm" | grep -aEio "user=[a-zA-Z0-9_-]+" | cut -d "=" -f2 | sort -u)

    echo "----------------------------------------"
    echo "--------CONSOLA DE ACCESO AL S.O.-------"
    echo "----------------------------------------"
    echo "Número de intentos fallidos: $num_gdm"
    echo ""
    echo -e "Usuarios afectados:\n${users_gdm:-Ninguno detectado}"
    echo ""
}

analizar_fallos_sudo() {
    # Filtra intentos fallidos al invocar comandos con sudo o cambio de usuario
    local fallos_sudo
    fallos_sudo=$(grep -aEi "password check failed for user" "$LOG_FILE")
    
    local num_sudo
    num_sudo=$(echo -n "$fallos_sudo" | grep -c "^")
    [ -z "$fallos_sudo" ] && num_sudo=0

    local users_sudo
    users_sudo=$(echo "$fallos_sudo" | grep -aEi "user .*" | cut -d "(" -f 2 | cut -d ")" -f 1 | sort -u)

    echo "--------------------------------------------"
    echo "--------FALLOS DE EJECUCIÓN CON ROOT--------"
    echo "--------------------------------------------"
    echo "Número de intentos fallidos: $num_sudo"
    echo ""
    echo -e "Usuarios afectados (desde donde se intentó escalar):\n${users_sudo:-Ninguno detectado}"
    echo ""
}

analizar_accesos_ssh() {
    # Filtra intentos fallidos recibidos a través del servicio SSH
    local fallos_ssh
    fallos_ssh=$(grep -aEi "failed password for.*from.*" "$LOG_FILE")
    
    local num_ssh
    num_ssh=$(echo -n "$fallos_ssh" | grep -c "^")
    [ -z "$fallos_ssh" ] && num_ssh=0

    local users_ssh
    users_ssh=$(echo "$fallos_ssh" | grep -aEoi "for (invalid user )?[a-zA-Z0-9_-]+" | awk '{print $NF}' | sort -u)

    local ips_ssh
    ips_ssh=$(echo "$fallos_ssh" | grep -aEoi "from [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | cut -d " " -f 2 | sort -u)

    echo "--------------------------------------------"
    echo "--------FALLOS DE ACCESO POR SSH------------"
    echo "--------------------------------------------"
    echo "Número de intentos fallidos: $num_ssh"
    echo ""
    echo -e "Usuarios afectados:\n${users_ssh:-Ninguno detectado}"
    echo ""
    echo -e "IPs atacantes registradas:\n${ips_ssh:-Ninguna detectada}"
    echo ""
}

# --- 3. Ejecución principal ---
echo "================================================================================"
echo "                           LOGIN LOG ANALYZER (AUDITORÍA)                       "
echo "================================================================================"
echo ""

# Cálculo general de eventos
total_fallos=$(grep -aEic "gdm-password.*authentication failure|password check failed for user|failed password for.*from.*" "$LOG_FILE")

echo "Total de intentos fallidos registrados en el sistema: $total_fallos"
echo ""

# Llamada a las funciones modulares
analizar_accesos_locales
analizar_fallos_sudo
analizar_accesos_ssh
