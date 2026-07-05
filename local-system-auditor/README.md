# Local System Auditor & Forensic Gatherer

Este módulo contiene una herramienta automatizada de auditoría interna y recolección de artefactos forenses locales para sistemas Linux (`basic_linux_audit.sh`). 

El script ha sido diseñado para proporcionar a un administrador o analista de seguridad una radiografía instantánea de la seguridad local del host, facilitando la detección de configuraciones débiles, identidades sospechosas o indicadores de compromiso (IoCs).

---

## Funcionalidades del Script

El script automatiza de forma secuencial la extracción y el formateo de los siguientes componentes críticos del sistema:

1. **Recolección de Información Básica:** Registra de forma limpia el nombre de red del host (`hostname`) y la identidad del operador que ejecuta la auditoría (`whoami`).
2. **Clasificación de Identidades (UID >= 1000):** Analiza el fichero `/etc/passwd` y clasifica mediante lógica matemática a los usuarios interactivos creados en el sistema separados de las cuentas de servicio por defecto, aislando y filtrando de forma inteligente la cuenta especial `nobody`.
3. **Auditoría de Acceso a Consola (Shells Activas):** Evalúa el entorno identificando qué usuarios tienen asignadas terminales funcionales (como `/bin/bash`) frente a las que están deshabilitadas (`/bin/false` o `/usr/sbin/nologin`).
4. **Monitorización de Procesos Críticos (Top CPU):** Genera un reporte optimizado con las columnas esenciales (`user,pid,%cpu,%mem,comm`) ordenado por consumo de hardware, empleando selectores cortos para omitir argumentos extensos y evitar distorsiones en la terminal.
5. **Mapeo de Servicios Activos:** Lista en tiempo real los demonios y servicios del sistema que se encuentran actualmente en ejecución (`running`) a través de `systemctl`.
6. **Análisis de Registros de Autenticación:** Inspecciona las últimas líneas de actividad del fichero `/var/log/auth.log` para evaluar de forma rápida vectores de ataque comunes como intentos de fuerza bruta por SSH.
7. **Control de Privilegios en Archivos:** Examina el directorio de trabajo para listar y advertir sobre ficheros locales con permisos de escritura activos, mitigando riesgos de inyección de código.

---

## Uso y Ejecución

Para un análisis forense completo (especialmente para la lectura de sockets de procesos y logs de autenticación), se recomienda otorgar permisos y lanzar el script con privilegios elevados:

```bash
# Otorgar permisos de ejecución
chmod +x basic_linux_audit.sh

# Ejecutar auditoría completa
sudo ./basic_linux_audit.sh
