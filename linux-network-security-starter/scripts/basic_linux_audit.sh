#!/bin/bash
# ==============================================================================
# Script: basic_linux_audit.sh
# Autor: Deniz Shoray Saliev Nikolov
# Descripción: Auditoría inicial del sistema Linux.
#              Revisa usuarios estándar (UID >= 1000), shells interactivas,
#              consumo de procesos y ficheros con permisos abiertos de escritura.
# Requisitos: Intérprete Bash y comandos estándar del sistema (/etc/passwd).
# ==============================================================================

set -u

# --- 1. Funciones de auditoría ---

auditar_usuarios_reales() {
    echo "--------------------------------------------------"
    echo "1. CUENTAS DE USUARIOS ESTÁNDAR (UID >= 1000)"
    echo "--------------------------------------------------"
    local passwd_file="/etc/passwd"

    if [ ! -r "$passwd_file" ]; then
        echo "[ERROR] No se puede leer el archivo $passwd_file."
        return 1
    fi

    # Filtra usuarios reales (UID entre 1000 y 60000, excluyendo nobody)
    local usuarios
    usuarios=$(awk -F: '$3 >= 1000 && $3 < 60000 {printf "Usuario: %-15s | UID: %-5s | Home: %s\n", $1, $3, $6}' "$passwd_file")

    if [ -n "$usuarios" ]; then
        echo "$usuarios"
    else
        echo "No se encontraron usuarios estándar en el sistema."
    fi
    echo ""
}

auditar_shells_interactivas() {
    echo "--------------------------------------------------"
    echo "2. USUARIOS CON SHELL INTERACTIVA (/bin/bash, /bin/sh)"
    echo "--------------------------------------------------"
    # Identifica usuarios que tienen acceso a un intérprete de comandos interactivo
    local shells
    shells=$(grep -E '(/bin/bash|/bin/sh|/bin/zsh)$' /etc/passwd | awk -F: '{printf "%-15s -> Shell: %s\n", $1, $7}')

    if [ -n "$shells" ]; then
        echo "$shells"
    else
        echo "No se detectaron usuarios con shells interactivas estándar."
    fi
    echo ""
}

procesos_alto_consumo() {
    echo "--------------------------------------------------"
    echo "3. PROCESOS CON MAYOR CONSUMO DE RECURSOS (TOP 5)"
    echo "--------------------------------------------------"
    echo "Mayor uso de CPU:"
    ps -eo pid,user,%cpu,comm --sort=-%cpu | head -n 6
    echo ""
    echo "Mayor uso de Memoria (RAM):"
    ps -eo pid,user,%mem,comm --sort=-%mem | head -n 6
    echo ""
}

comprobar_permisos_inseguros() {
    echo "--------------------------------------------------"
    echo "4. COMPROBACIÓN DE PERMISOS DE ESCRITURA EN DIRECTORIO ACTUAL"
    echo "--------------------------------------------------"
    echo "Buscando archivos o carpetas con permisos de escritura para 'otros' (o+w)..."
    
    # Busca elementos con permisos de escritura pública dentro de la ruta de ejecución
    local inseguros
    inseguros=$(find . -maxdepth 2 -perm -o+w ! -type l 2>/dev/null)

    if [ -n "$inseguros" ]; then
        echo "[AVISO] Se han encontrado elementos con permisos de escritura global:"
        echo "$inseguros"
    else
        echo "[OK] No se detectaron ficheros con permisos débiles (world-writable) en este nivel."
    fi
    echo ""
}

# --- 2. Ejecución principal ---
clear
echo "=================================================="
echo "           AUDITORÍA BÁSICA DE SISTEMA LINUX       "
echo "=================================================="
echo ""

auditar_usuarios_reales
auditar_shells_interactivas
procesos_alto_consumo
comprobar_permisos_inseguros
