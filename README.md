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
