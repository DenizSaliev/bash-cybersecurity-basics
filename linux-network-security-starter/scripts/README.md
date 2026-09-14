## Herramientas Disponibles

### [1. Network Diagnostics](./network-diagnostics/)
- **Script:** `check_network.sh`
- **Propósito:** Automatiza el diagnóstico de conectividad en múltiples capas (Capa 3 y Capa 7), mapea el direccionamiento IP/Gateway y analiza la superficie de ataque local listando puertos abiertos mediante `ss`.
- **Ideal para:** Verificaciones rápidas previas a auditorías o despliegues de servidores.

### [2. Local System Auditor](./local-system-auditor/)
- **Script:** `basic_linux_audit.sh`
- **Propósito:** Clasifica identidades de forma matemática por rangos de privilegios (UID >= 1000), audita la presencia de shells interactivas (/bin/bash), monitoriza procesos críticos según el consumo de hardware y audita permisos débiles en el directorio de trabajo.
- **Ideal para:** Bastionado (*hardening*) inicial de servidores y detección temprana de indicadores de compromiso (IoCs).

---
### [3. SIEM Log Analyzer Auditor](./login_log_analyzer/)

* **Script:** `login_log_analyzer.sh`
* **Propósito:** Automatiza el análisis y la centralización de fallos de autenticación correlacionando tres vectores de acceso críticos: control de interfaz gráfica (`gdm-password`), escalada local de privilegios (`sudo` / `su`) y fuerza bruta remota (`sshd`) con aislamiento unívoco de IPs y usuarios afectados.
* **Ideal para:** Monitorización de seguridad del host, auditoría interna de accesos y fases de triaje inicial en respuesta a incidentes.
