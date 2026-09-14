# Bash Scripting & Fundamentos de Seguridad en Linux

Bienvenido a este repositorio. Soy Deniz Shoray Saliev Nikolov, estudiante del ciclo formativo de grado superior en **ASIR** (Administración de Sistemas Informáticos en Red). 

Este repositorio reúne un conjunto de scripts sencillos y prácticas de laboratorio desarrolladas durante mi primer bloque de preparación técnica para orientar mi perfil hacia la ciberseguridad junior (seguridad defensiva / Blue Team).

El objetivo principal es consolidar una base práctica y sólida en la administración de entornos Linux, la automatización básica mediante Bash, el análisis inicial de registros de autenticación y la inspección de tráfico de red.

---

## Contenido del Repositorio

El proyecto integrador del primer mes se encuentra documentado dentro de la carpeta:

### [`linux-network-security-starter/`](./linux-network-security-starter/)
Reúne el conjunto de herramientas iniciales desarrolladas durante las primeras cuatro semanas:

1. **`scripts/check_network.sh`**: Comprobación rápida de conectividad local y externa (Capa 3 y 7), identificación de interfaces de red y listado de puertos en escucha mediante `ss`.
2. **`scripts/basic_linux_audit.sh`**: Script para inspección básica del sistema: conteo de usuarios estándar (UID >= 1000), detección de shells interactivas (`/bin/bash`), procesos con alto consumo de recursos y comprobación de permisos de escritura.
3. **`scripts/login_log_analyzer.sh`**: Parser defensivo que audita `/var/log/auth.log` para contar e identificar intentos fallidos de autenticación en entorno gráfico (`gdm`), escalada de privilegios (`sudo`) y conexiones remotas (`sshd`).
4. **`docs/wireshark-basic-analysis.md`**: Memoria técnica donde se analiza una captura de red (`web_dns_capture.pcapng`), explicando la resolución DNS sobre UDP y el Three-Way Handshake de TCP.
5. **`docs/month1-reflection.md`**: Reflexión estructurada sobre el aprendizaje y las dificultades encontradas durante el mes.
6. **`docs/improvements-week1.md`**: Registro de mejoras y refactorización de código aplicadas tras la revisión técnica.

---

##  Requisitos y Ejecución General

* **Sistema operativo:** Probado en Ubuntu Linux.
* **Intérprete:** Bash 4.x o superior.
* **Permisos:** Algunos scripts (como el lector de logs) requieren privilegios de administración (`sudo`) para acceder a rutas restringidas como `/var/log/auth.log`.

```bash
# Otorgar permisos de ejecución a los scripts
chmod +x linux-network-security-starter/scripts/*.sh

# Ejecutar cualquiera de las herramientas
./linux-network-security-starter/scripts/check_network.sh
