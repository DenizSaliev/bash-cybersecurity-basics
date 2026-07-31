
# Memoria de Reflexión — Mes 1

## 1. Qué sabía antes de empezar
Al comenzar el mes, contaba con conocimientos teóricos básicos sobre sistemas operativos e informática general fruto de mis estudios de ASIR. Sin embargo, no había aplicado de forma práctica y combinada el scripting en Bash para la resolución de problemas reales de seguridad defensiva.

## 2. Qué he aprendido sobre Bash
He descubierto que Bash no es solo una forma de lanzar comandos en orden, sino un lenguaje de automatización extremadamente potente para la ciberseguridad. He aprendido a:
- Manipular y filtrar flujos de texto complejos combinando tuberías (`|`), `grep`, `cut`, `sort -u` y `wc`.
- Resolver errores de ejecución reales, como la gestión de bytes nulos corruptos en archivos de log mediante la bandera `-a`.
- Formatear salidas por pantalla legibles para un análisis rápido durante un triaje inicial.

## 3. Qué he aprendido sobre Linux
He afianzado la arquitectura interna del sistema operativo Ubuntu Linux:
- La estructura del árbol de directorios y la importancia crítica de ficheros de registro como `/var/log/auth.log`.
- El modelo de permisos, la jerarquía de usuarios según su UID (diferenciando usuarios de sistema de usuarios reales) y los riesgos asociados a la escalada de privilegios mediante `sudo`.
- El funcionamiento de los servicios locales y la inspección de procesos en tiempo real.

## 4. Qué he aprendido sobre redes
Gracias al uso de herramientas como `ss` y el analizador de paquetes Wireshark:
- Comprendí de manera práctica cómo interactúan las capas del modelo TCP/IP.
- Comprobé cómo la navegación web depende estrictamente de una consulta DNS previa en UDP (Puerto 53).
- Pude aislar y auditar las tres fases del *TCP Three-Way Handshake* (`SYN`, `SYN-ACK`, `ACK`) para el establecimiento de comunicaciones fiables en el puerto 443.

## 5. Qué relación veo entre sistemas y ciberseguridad
He comprendido que **no se puede defender lo que no se sabe cómo funciona**. La ciberseguridad no es una disciplina aislada, sino una capa que se construye directamente sobre la administración de sistemas y redes. Para detectar un ataque, identificar una anomalía en un log o entender una intrusión por SSH, es imprescindible conocer previamente cómo opera el sistema operativo de forma normal. Un buen analista de seguridad debe ser primero un buen técnico de sistemas.

## 6. Qué parte me ha costado más
La parte que me ha requerido un mayor esfuerzo cognitivo ha sido la depuración de scripts al manipular cadenas de texto complejas (extraer usuarios situados entre caracteres especiales como paréntesis) y la interpretación de filtros avanzados en Wireshark cuando se mezclaban conexiones IPv4 e IPv6 de manera simultánea durante la navegación.

## 7. Qué quiero mejorar el mes que viene
- **Optimización de código:** Escribir scripts de Bash aún más modulares, incorporando estructuras de control de errores más sólidas y funciones reutilizables.
- **Profundidad en redes:** Iniciar el estudio de protocolos de capa de red más complejos y técnicas de análisis de tráfico cifrado.
- **Documentación:** Mantener el hábito de documentar en GitHub cada pequeño avance, consolidando una marca personal orientada al sector técnico.
