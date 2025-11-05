#/bin/bash
#==============================================================
# Nombre: Contar.sh
# Descripción: Contar archivos en carpeta
# Autor: Yeray Gutierrez Mullor
# Fecha:05/11/2025
# Versión:
# Uso: Contar archivos en carpetas
# Comentarios:
#==============================================================
if [ $# -eq 1 ]
then directorio=$1
else
    directorio=$home
fi

if [ ! -d $directorio ]
then
    echo "error"
    exit 1
fi
num=$(ls -1 "$directorio" | wc -l)
echo "Hay $num archivos"