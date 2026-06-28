# bash-cybersecurity-basics
## 🚀 Funcionalidades del script

El script se ejecuta en un bucle continuo (`while true`) mostrando un menú interactivo con las siguientes opciones:

1. **Mostrar dirección IP:** Extrae de forma limpia la dirección IP local de la máquina, omitiendo las interfaces de loopback (`127.0.0.1`).
2. **Mostrar puerta de enlace:** Identifica el Gateway predeterminado por el que sale el tráfico.
3. **Mostrar DNS configurado:** Lee el archivo "/etc/resolv.conf" para mostrar los servidores de resolución de nombres activos.
4. **Comprobar conectividad:** Realiza un "ping" silencioso a "8.8.8.8" (Google) para verificar la salida a Internet.
5. **Comprobar resolución DNS:** Utiliza "nslookup" para verificar si el sistema es capaz de traducir dominios correctamente.
6. **Mostrar puertos abiertos en local:** Escanea los puertos que estén escuchando utilizando la herramienta "ss", filtrando duplicados para mostrar qué servicios locales podrían ser vulnerables.
7. **Salir:** Finaliza la ejecución del script de forma controlada con un "exit 0".

## ⚙️ Uso y Ejecución

Para ejecutar el script, es necesario otorgarle permisos de ejecución y lanzarlo desde la terminal. Se recomienda ejecutarlo con privilegios elevados (sudo) para que la opción 6 (ss) pueda leer correctamente todos los procesos asociados a los puertos en escucha.


# Dar permisos de ejecución
chmod +x check_network.sh

# Ejecutar el script (opcionalmente con sudo para ver todos los puertos)
bash check_network.sh

# Qué he aprendido:
El uso del comando awk, no lo había usado nunca antes.

Repaso de comandos de red generales.

# Errores o dificultades encontradas
Filtrar la información de los comandos para obtener única y exclusivamente lo que necesito

Puertos duplicados al usar ss: Al listar los puertos en escucha, aparecían múltiples veces si un servicio escuchaba en IPv4 e IPv6. Lo solucione con un array y un bucle for, pero también se puede hacer con el comando sort -u.
