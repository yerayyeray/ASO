# Practica 1: Administracion Remota

---

## Parte 1: Windows Admin Center (WAC):
| Sistema | Usuario remoto | Herramienta | Protocolo | Puerto |
|---------|----------------|-------------|-----------|--------|
| Windows 11 | usuario | Windows Admin Center | HTTPS | 6600 |

### Instalar WAC:
Descargar el ejecutable desde la web oficial de microsoft y completar la instalación
![Instalacion]("./Capturas/1.1_wac_instalacion.png")

### Firewall de Windows Server:
Implementar esta regla en el Windows Server para permitir la conexión desde el WAC
![Firewall](.\Capturas\1.2_wac_reglasfirewallserver.png)

### Acceso a Windows Admin Center:
Acceder a WAC desde la URL que se muestra tras la instalación y poner las credenciales del usuario local
![Acceso](.\Capturas\1.3_wac_acceso.png)
Al acceder se muestra la pagina de inicio con las conexiones
![Acceso](.\Capturas\1.4_wac_menu.png)

### Añadir Windows Server a WAC:
Ir a la pestaña "Agregar" y "Agregar manualmente"
![Acceso](.\Capturas\1.5_wac_añadirserver.png)
Elegir la opcion "Servidores" y "Agregar"
![Acceso](.\Capturas\1.6_wac_añadirserver2.png)
Introducir la IP y elegir la opción de "Usar otra cuenta para esta conexión"
![Acceso](.\Capturas\1.7_wac_conexioncredenciales.png)
Si todo va bien aparecerá el nombre del Server con un icono verde
![Acceso](.\Capturas\1.8_wac_conectado.png)
Ahora deberia aparecer el Windows Server en la lista de conexiones
![Acceso](.\Capturas\1.9_wac_servidorconectado.png)

### Prueba de conexion con el servidor desde WAC:
Prueba de que hay acceso al Windows Server
![Acceso](.\Capturas\1.10_wac_servidor.png)

---

## Parte 2: Cockpit
| Sistema | Usuario remoto | Herramienta | Protocolo | Puerto |
|---------|----------------|-------------|-----------|--------|
| Linux | yeray | Cockpit | https | 9090 |

### Comprobar que Cockpit esta instalado en Ubuntu Server:
Hacer comprobación de que Cockpit esta instalado con 'systemctl' y si no lo esta, instalarlo
![Cockpit](.\Capturas\2.1_cockpit_instalado.png)

### Crear un usuario para la conexion remota:
Crear un usuario para la conexión remota desde Windows 11
![CrearUsuario](.\Capturas\2.2_cockpit_crearusuario.png)
Darle permisos sudo
![DarPermisos](.\Capturas\2.3_cockpit_privilegiosusuarios.png)

### Acceder a Cockpit desde Windows:
Desde Windows 11 abrir navegador e ir a la url de la ip del Ubuntu Server desde el puerto 9090
![Acceso](.\Capturas\2.4_cockpit_acceso.png)

### Prueba de Monitorizacion:
Pantalla de inicio de Cockpit donde se muestra la monitorizacion de la CPU y la memoria
![Monitorizacion](.\Capturas\2.5_cockpit_monitorizacion.png)


