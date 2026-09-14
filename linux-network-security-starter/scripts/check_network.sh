#!/bin/bash
# ==============================================================================
# Script: check_network.sh
# Autor: Deniz Shoray Saliev Nikolov
# Descripción: Script de diagnóstico de red básico en Linux.
#              Comprueba interfaces, gateway, conectividad externa y puertos en escucha.
# Requisitos: Conexión de red activa y herramientas estándar de iproute2/iputils.
# ==============================================================================

set -u  # Detiene la ejecución si se usa una variable no declarada

# --- 1. Verificación de dependencias mínimas ---
verificar_dependencias() {
    local herramientas=("ip" "ping" "curl" "ss")
    for cmd in "${herramientas[@]}"; do
        if ! command -v "$cmd" &>/dev/null; then
            echo "[AVISO] La herramienta '$cmd' no está instalada o no está en el PATH."
        fi
    done
}

# --- 2. Funciones de diagnóstico ---

mostrar_interfaces() {
    echo "--------------------------------------------------"
    echo "1. DIRECCIONAMIENTO IP E INTERFACES ACTIVAS"
    echo "--------------------------------------------------"
    # Extrae el nombre de la interfaz y su IPv4 descartando el loopback
    ip -4 -br addr show | grep -v "lo" | while read -r iface status ip; do
        echo "Interfaz: $iface | Estado: $status | IP: $ip"
    done
    echo ""
}

comprobar_gateway() {
    echo "--------------------------------------------------"
    echo "2. COMPROBACIÓN DE PUERTA DE ENLACE (GATEWAY)"
    echo "--------------------------------------------------"
    local gw
    gw=$(ip route show default 2>/dev/null | awk '/default/ {print $3}')

    if [ -n "$gw" ]; then
        echo "Puerta de enlace detectada: $gw"
        if ping -c 2 -W 2 "$gw" &>/dev/null; then
            echo "[OK] Respuesta correcta al ping del Gateway."
        else
            echo "[FALLO] El Gateway no responde a peticiones ICMP (ping)."
        fi
    else
        echo "[ERROR] No se ha detectado una ruta predeterminada (Default Gateway)."
    fi
    echo ""
}

comprobar_conectividad_externa() {
    echo "--------------------------------------------------"
    echo "3. CONECTIVIDAD EXTERNA Y RESOLUCIÓN DNS (CAPA 3 / 7)"
    echo "--------------------------------------------------"
    
    # Capa 3: Ping directo a IP pública conocida (Quad9 DNS)
    if ping -c 2 -W 2 9.9.9.9 &>/dev/null; then
        echo "[OK] Conectividad a Internet por IP (Capa 3 - ICMP): Correcta."
    else
        echo "[FALLO] Sin conectividad hacia el exterior vía IP."
    fi

    # Capa 7: Petición HTTP directa para validar DNS y transporte web
    if curl -s --head --connect-timeout 3 http://www.google.com &>/dev/null; then
        echo "[OK] Resolución de nombres y acceso web (Capa 7 - HTTP/DNS): Correcta."
    else
        echo "[FALLO] Fallo en la resolución de nombres o acceso HTTP hacia el exterior."
    fi
    echo ""
}

listar_puertos_escucha() {
    echo "--------------------------------------------------"
    echo "4. SERVICIOS Y PUERTOS TCP EN ESCUCHA (LISTENING)"
    echo "--------------------------------------------------"
    echo "Comprobando sockets abiertos localmente..."
    echo ""
    # Muestra sockets TCP abiertos en formato legible
    if command -v ss &>/dev/null; then
        ss -tuln -H | awk '{printf "%-6s %-25s\n", $1, $5}' | sort -u
    else
        echo "[ERROR] No se pudo ejecutar 'ss' para listar los sockets."
    fi
    echo ""
}

# --- 3. Ejecución principal ---
clear
echo "=================================================="
echo "          DIAGNÓSTICO BÁSICO DE RED LOCAL         "
echo "=================================================="
echo ""

verificar_dependencias
mostrar_interfaces
comprobar_gateway
comprobar_conectividad_externa
listar_puertos_escucha
