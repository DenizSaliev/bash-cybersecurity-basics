# Registro de Mejoras y Refactorización — Semana 1

Este documento recoge los cambios y optimizaciones técnicas aplicadas sobre el entregable del primer mes tras la primera revisión técnica del proyecto.

---

## 1. Qué he corregido
- **Validación de archivos y permisos en los scripts:** Se añadieron comprobaciones condicionales (`if [ ! -f ]` e `if [ ! -r ]`) para asegurar que el archivo `/var/log/auth.log` exista y que el script se ejecute con privilegios de superusuario (`sudo`), emitiendo mensajes de error claros en caso contrario.
- **Estructuración del código:** Se eliminaron comandos redundantes y llamadas múltiples a `cat`. El script `login_log_analyzer.sh` ahora utiliza funciones modulares y variables locales para cada vector de autenticación analizado.
- **Ajuste de tono en la documentación:** Se eliminaron términos desproporcionados para un perfil junior (como "SIEM local", "herramienta forense avanzada" o "capacidades de triage corporativo"), sustituyéndolos por explicaciones directas, honestas y técnicamente precisas.
- **Presentación general del repositorio:** Se redactó un `README.md` completo en la raíz del repositorio con información sobre mi perfil formativo, descripción general, requisitos y topics técnicos acordes.

---

## 2. Por qué lo he corregido
- **Robustez técnica:** Un script que asume que siempre tiene permisos o que el archivo existe fallará silenciosamente o devolverá errores confusos en otros entornos Linux. Controlar los fallos hace que el código sea predecible y fiable.
- **Credibilidad profesional:** En un perfil junior, hablar de herramientas introductorias como si fueran soluciones empresariales resta seriedad. Es preferible demostrar claridad sobre lo que hace el script y por qué funciona.
- **Buenas prácticas de desarrollo:** Reducir la repetición de código (`DRY - Don't Repeat Yourself`) y documentar mediante comentarios facilita el mantenimiento y la lectura por parte de terceros.

---

## 3. Qué he aprendido revisando mi propio código
Revisar código propio requiere adoptar una mirada crítica:
- Descubrí que canalizar archivos repetidamente con `cat` antes de un `grep` (`useless use of cat`) penaliza el rendimiento de forma innecesaria cuando `grep` puede leer el archivo de forma directa.
- Comprendí la importancia del código de salida (`exit 1`) para detener la ejecución de un programa cuando los requisitos mínimos no se cumplen.
- Asimilé que la claridad y la sencillez técnica tienen mucho más valor formativo que intentar que un proyecto parezca más grande de lo que realmente es.
