# SIEM Log Analyzer & Auth Parser

Este módulo contiene un script automatizado en Bash (`login_log_analyzer.sh`) diseñado para centralizar, filtrar y parsear de forma estructurada los registros de autenticación del sistema en Linux (`/var/log/auth.log`).

---

## Funcionalidades del Script

El script analiza de forma diferenciada tres vectores esenciales de entrada al sistema:

1. **Acceso Local (Consola/S.O.):** Identifica intentos fallidos en la interfaz gráfica (`gdm-password`).
2. **Escalada de Privilegios (Root):** Reporta fallos al intentar ejecutar comandos como superusuario (`sudo`) o cambiar de cuenta local (`su`).
3. **Acceso Remoto (SSH):** Filtra intentos de intrusión por red (`sshd`), extrayendo las direcciones IP atacantes de forma unívoca.

---

## Aprendizajes Clave del Desarrollo
- **Tratamiento de bytes nulos:** Implementación del flag `-a` en `grep` para procesar archivos de log que contengan caracteres no imprimibles o corruptos, evitando que el script falle.
- **Expresiones Regulares (Regex):** Uso de `grep -Eio` con patrones avanzados para aislar variables textuales complejas (como usuarios entre paréntesis).
- **Tratamiento de duplicados:** Uso combinado de tuberías (`|`) con `sort -u` para ofrecer reportes limpios, legibles y consolidados en la terminal.
