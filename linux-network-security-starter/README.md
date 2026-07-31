# Linux & Network Security Starter Kit

Bienvenido al proyecto integrador del **Primer Mes** de mi preparación orientada a **Ciberseguridad Junior / Blue Team**. Este repositorio unifica las herramientas desarrolladas, los análisis de tráfico de red y las evidencias de laboratorio para demostrar capacidades prácticas en administración de sistemas, automatización con Bash Scripting y auditoría defensiva.

---

## Sobre Mí
- **Nombre:** Deniz Shoray Saliev Nikolov
- **Perfil:** Estudiante de ASIR | Técnico de Sistemas enfocado a Ciberseguridad (SOC / Blue Team / Linux Security).
- **Objetivo:** Construir una base técnica sólida e inquebrantable en administración de infraestructuras Linux, análisis forense de logs y fundamentos de redes antes de dar el salto a metodologías defensivas avanzadas.

---

## Herramientas Utilizadas
- **Sistema Operativo:** Ubuntu Linux
- **Lenguajes & Shell:** Bash Scripting (Grep, Cut, Sed, Regex, Sort, Uniq)
- **Análisis de Red:** Wireshark, Nslookup, SS / Netstat
- **Control de Versiones & Docs:** Git, GitHub, Markdown, VS Code

---

## Contenido del Repositorio

### 1. `scripts/` (Automatización y Auditoría)
* **`check_network.sh`**: Diagnóstico automatizado de red en Capa 3 y 7, mapeo de gateways y listado de sockets/puertos abiertos para evaluar la superficie de exposición.
* **`basic_linux_audit.sh`**: Recolección de artefactos forenses locales, clasificación de usuarios por rango UID (identificación de cuentas con privilegios), detección de shells interactivas y permisos débiles.
* **`login_log_analyzer.sh`**: Parser defensivo simulador de SIEM local que audita `/var/log/auth.log`, unificando accesos gráficos (`gdm`), escaladas de privilegios (`sudo`) y ataques remotos (`sshd`).

### 2. `captures/` & `docs/` (Auditoría de Tráfico)
* **`captura_dns.png` & `captura_tcp.png`**: Evidencias fotográficas de la resolución de nombres UDP y el apretón de manos de 3 vías de TCP.
* **`wireshark-basic-analysis.md`**: Análisis documental detallado del comportamiento de protocolos de transporte y aplicación.
* **`month1-reflection.md`**: Memoria técnica y reflexión personal sobre el progreso acumulado en el mes.

---

## Cómo Ejecutar los Scripts

Asegúrate de otorgar permisos de ejecución antes de lanzar cualquiera de las herramientas:

```bash
# Dar permisos de ejecución
chmod +x scripts/*.sh

# Ejecutar el analizador de red
./scripts/check_network.sh

# Ejecutar la auditoría de sistema
./scripts/basic_linux_audit.sh

# Ejecutar el analizador de logs de autenticación (requiere acceso a /var/log/auth.log)
sudo ./scripts/login_log_analyzer.sh
