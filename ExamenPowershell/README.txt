README - Inventario de PC Mejorado
==================================

Descripción
-----------
Este script de PowerShell realiza un inventario del sistema, recopilando información de BIOS, sistema operativo y hardware, y exporta los datos a un archivo CSV. Incluye mejoras como logs detallados, comprobación de rutas y control de errores.

Parámetros implementados
-----------------------
- OutputPath: Carpeta donde se guardará el CSV del inventario. (Por defecto: H:\ASR2\Practica_PS)
- LogPath: Carpeta donde se guardarán los logs del script. (Por defecto: H:\ASR2\Practica_PS\logs)
- SessionCode: Código de sesión para identificar el inventario y los logs. (Por defecto: UT1_P1_YGM)

Qué ocurre si no hay red
------------------------
Si la ruta de red especificada en OutputPath no está disponible:
- Se mostrará una advertencia en consola.
- Se usará una ruta alternativa en la carpeta de Documentos del usuario: Documentos\Script.
- Se registrará el evento en el log.

Dónde se guarda el inventario
-----------------------------
- Por defecto, el inventario se guarda en la carpeta indicada por OutputPath con el nombre:
  <NombreDelPC>-UT1_P1_YGM.csv
- Los logs se guardan en LogPath con el nombre:
  UT1_P1_YGM-log.txt

Cómo ejecutar el script
----------------------
Abrir PowerShell y ejecutar el script con los parámetros deseados. Ejemplo:

    .\Inventario_PC.ps1 -OutputPath "H:\ASR2\Practica_PS" -LogPath "H:\ASR2\Practica_PS\logs" -SessionCode "UT1_P1_YGM"

Si no se especifican parámetros, se usarán los valores por defecto.

Mejoras implementadas
--------------------
1. Parámetros configurables: OutputPath, LogPath, SessionCode.
2. Comprobación y creación de rutas: asegura que existan las carpetas necesarias.
3. Ruta alternativa si no hay red.
4. Test-WriteAccess: prueba de permisos de escritura antes de guardar archivos.
5. Logs detallados: Write-Log con niveles INFO, WARN y ERROR.
6. Control de errores: manejo con try/catch en operaciones críticas.
7. Mensajes informativos: Write-Verbose y Write-Warning para feedback al usuario.

