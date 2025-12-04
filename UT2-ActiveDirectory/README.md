# README – Unidad 2: Active Directory y Servicios de Red

En esta unidad he trabajado con la implementación de una red basada en **Active Directory**, configurando tanto la infraestructura como los servicios esenciales para que funcione un dominio corporativo. El objetivo ha sido aprender a desplegar, organizar y gestionar un entorno centralizado.

---

## Contenido de la Unidad

### 1. Configuración de pfSense con DHCP
He configurado pfSense como servidor DHCP, definiendo el rango de IPs, la puerta de enlace y el DNS (apuntando al futuro controlador de dominio). Con esto he preparado la red para que los equipos obtengan configuración automáticamente.

### 2. Promoción del Servidor a Controlador de Dominio
Instalé el rol de **Active Directory Domain Services** y promoví el servidor a **Controlador de Dominio**, creando un nuevo dominio. También verifiqué servicios como DNS y SYSVOL para asegurar que el dominio funcionara correctamente.

### 3. Unión de Clientes al Dominio
Configuré los clientes para que usaran el DNS del servidor y los uní al dominio. Luego comprobé que podían iniciar sesión con cuentas del dominio.

### 4. Aplicación de Políticas (GPO)
Creé y vinculé una GPO a una OU, luego forcé la actualización en los clientes y verifiqué que se aplicara correctamente. Esto demuestra la administración centralizada que ofrece AD.

### 5. Creación de OUs, Grupos y Usuarios
Organicé el dominio creando Unidades Organizativas, usuarios y grupos de seguridad. Con esto establecí una estructura clara para gestionar permisos y políticas.

### 6. Carpetas Compartidas y Permisos
Creé carpetas compartidas en el servidor y configuré permisos NTFS y de recurso compartido, asignando el acceso a los grupos correspondientes. Después probé el acceso desde los clientes del dominio.

---

## Conclusión
En esta unidad he aprendido a montar una infraestructura completa con Active Directory: configuración de red, controlador de dominio, unión de clientes, organización del directorio y gestión de recursos. Esto me permitió entender cómo se administra una red empresarial real de forma centralizada.
