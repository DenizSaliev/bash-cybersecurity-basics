# Bash Cybersecurity Basics & Automation Lab

Este repositorio contiene un ecosistema de herramientas y scripts automatizados en Bash diseñados para optimizar tareas de administración avanzada de sistemas, auditoría local y diagnóstico defensivo en entornos Linux. 

Cada proyecto está desarrollado bajo estándares limpios, modulares y documentados detalladamente para servir como soluciones rápidas en operaciones de seguridad y administración de infraestructuras.

---

## Herramientas Disponibles

### [1. Network Diagnostics & Socket Analyzer](./network-diagnostics/)
- **Script:** `check_network.sh`
- **Propósito:** Automatiza el diagnóstico de conectividad en múltiples capas (Capa 3 y Capa 7), mapea el direccionamiento IP/Gateway y analiza la superficie de ataque local listando puertos abiertos mediante `ss`.
- **Ideal para:** Verificaciones rápidas previas a auditorías o despliegues de servidores.

### [2. Local System Auditor & Forensic Gatherer](./local-system-auditor/)
- **Script:** `basic_linux_audit.sh`
- **Propósito:** Herramienta de recolección de artefactos forenses locales en Linux. Clasifica identidades de forma matemática por rangos de privilegios (UID >= 1000), audita la presencia de shells interactivas (/bin/bash), monitoriza procesos críticos según el consumo de hardware y audita permisos débiles en el directorio de trabajo.
- **Ideal para:** Bastionado (*hardening*) inicial de servidores y detección temprana de indicadores de compromiso (IoCs).

---
### [3. SIEM Log Analyzer Auditor](./login_log_analyzer/)

* **Script:** `login_log_analyzer.sh`
* **Propósito:** Automatiza el análisis y la centralización de fallos de autenticación correlacionando tres vectores de acceso críticos: control de interfaz gráfica (`gdm-password`), escalada local de privilegios (`sudo` / `su`) y fuerza bruta remota (`sshd`) con aislamiento unívoco de IPs y usuarios afectados.
* **Ideal para:** Monitorización de seguridad del host, auditoría interna de accesos y fases de triaje inicial en respuesta a incidentes.

### 4. Network Traffic Analysis & Protocol Auditing

* **Documentación:** `wireshark-basic-analysis.md`
* **Propósito:** Evaluación forense de una sesión de red capturada a través de Wireshark (`.pcapng`). Analiza la traducción de nombres de dominio (Query/Response de DNS sobre UDP) y audita la fase de negociación e inicio de sesión de transporte mediante la interceptación del *TCP Three-Way Handshake*.
* **Ideal para:** Análisis de flujos de comunicación, detección de anomalías en tránsito y fundamentos de seguridad en redes.
