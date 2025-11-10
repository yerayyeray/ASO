#==============================================================
# Nombre: UT1_practica1-GutierrezMullorYeray.ps1
# Descripción: Importar especificaciones del PC a un CSV
# Autor: Yeray Gutierrez Mullor
# Fecha:10/11/2025
# Versión: 1
# Uso: Importar especificaciones del PC a un CSV
# Comentarios: Examen
#==============================================================
<#
.SYNOPSIS
  Inventario de PC mejorado con parametrización, comprobación de rutas, logs y control de errores.
.DESCRIPTION
  Versión actualizada siguiendo las especificaciones del usuario:
   - param() con OutputPath, LogPath, SessionCode
   - comprobación y creación de rutas (con fallback a Documentos\Script)
   - Test-WriteAccess para probar escritura
   - Write-Log para registrar actividad
   - mensajes informativos con Write-Host / Write-Verbose / Write-Warning
   - manejo try/catch en operaciones críticas
.NOTES
  Sesión por defecto: UT1_P1_YGM (iniciales: YGM)
#>

param(
    [string]$OutputPath = "H:\ASR2\Practica_PS",
    [string]$LogPath    = "H:\ASR2\Practica_PS\logs",
    [string]$SessionCode = "UT1_P1_YGM"
)

# --- Inicialización ---
$ErrorActionPreference = "Stop"

$infoColl = @()
$csvFileName = "$env:COMPUTERNAME-UT1_P1_YGM.csv"
$logFileName = "UT1_P1_YGM-log.txt"

$alternativeBase = Join-Path -Path ([Environment]::GetFolderPath("MyDocuments")) -ChildPath "Script"
if (-not (Test-Path -Path $alternativeBase)) { New-Item -ItemType Directory -Path $alternativeBase -Force | Out-Null }
$alternativeLogPath = Join-Path -Path $alternativeBase -ChildPath "logs"
if (-not (Test-Path -Path $alternativeLogPath)) { New-Item -ItemType Directory -Path $alternativeLogPath -Force | Out-Null }

$logFullPath = Join-Path -Path $LogPath -ChildPath $logFileName
$logWarned = $false

function Write-Log {
    param(
        [ValidateSet("INFO","WARN","ERROR")] [string]$Level = "INFO",
        [Parameter(Mandatory=$true)][string]$Message
    )
    try {
        $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        $computer = $env:COMPUTERNAME
        $line = "[$timestamp] $Level $computer [$SessionCode] $Message"
        if (-not (Test-Path -Path $LogPath)) {
            try {
                New-Item -ItemType Directory -Path $LogPath -Force | Out-Null
            } catch {
                if (-not $logWarned) { Write-Warning "No se pudo crear la carpeta de logs '$LogPath'. Se usara ruta alternativa: $alternativeLogPath"; $logWarned = $true }
                $LogPath = $alternativeLogPath
                $logFullPath = Join-Path -Path $LogPath -ChildPath $logFileName
                if (-not (Test-Path -Path $LogPath)) { New-Item -ItemType Directory -Path $LogPath -Force | Out-Null }
            }
        }
        Add-Content -Path $logFullPath -Value $line
    } catch {
        if (-not $logWarned) { Write-Warning "Write-Log fallo: $_"; $logWarned = $true }
    }
}

function Test-WriteAccess {
    param([Parameter(Mandatory=$true)][string]$Path)
    try {
        if (-not (Test-Path -Path $Path)) { New-Item -ItemType Directory -Path $Path -Force | Out-Null }
        $tempFile = Join-Path -Path $Path -ChildPath ("tmp_write_test_{0}.tmp" -f (Get-Random))
        $bytes = [byte[]]@(0x0)
        [System.IO.File]::WriteAllBytes($tempFile, $bytes)
        Remove-Item -Path $tempFile -Force -ErrorAction SilentlyContinue
        return $true
    } catch {
        return $false
    }
}

# --- Comprobación y creación de rutas ---
$networkAvailable = Test-Path -Path $OutputPath
if (-not $networkAvailable) {
    Write-Warning "No se puede acceder a $OutputPath. Se usara ruta alternativa: $alternativeBase"
    Write-Log -Level "WARN" -Message "Sin conexión de red a $OutputPath. Usando $alternativeBase"
    $OutputPath = $alternativeBase
    $LogPath = $alternativeLogPath
    $logFullPath = Join-Path -Path $LogPath -ChildPath $logFileName
}

if (-not (Test-WriteAccess -Path $OutputPath)) {
    Write-Warning "No se puede escribir en '$OutputPath'. Abortando script."
    Write-Log -Level "ERROR" -Message "Sin acceso de escritura en $OutputPath. Abortando script."
    throw "Sin ruta de escritura disponible."
}

Write-Host "Obteniendo datos del sistema..."
Write-Log -Level "INFO" -Message "Inicio de inventario."

try {
    $bios = Get-CimInstance -ClassName Win32_BIOS -ErrorAction Stop
    $os = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
    $comp = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop

    $obj = [PSCustomObject]@{
        ComputerName = $env:COMPUTERNAME
        Manufacturer = $comp.Manufacturer
        Model        = $comp.Model
        SerialNumber = ($bios.SerialNumber -as [string])
        OS           = $os.Caption
        OSVersion    = $os.Version
        LastBootUp   = $os.LastBootUpTime
        CollectedOn  = (Get-Date).ToString("s")
    }

    $infoColl += $obj
    Write-Log -Level "INFO" -Message "Datos del sistema recopilados."
} catch {
    Write-Warning "Error al obtener datos del sistema: $_"
    Write-Log -Level "ERROR" -Message "Error al obtener datos del sistema: $_"
}

$exportPath = Join-Path -Path $OutputPath -ChildPath $csvFileName
Write-Host "Exportando CSV a $exportPath ..."
try {
    if (-not $infoColl) { $infoColl = @() }
    $infoColl | Export-Csv -Path $exportPath -NoTypeInformation -Force -ErrorAction Stop
    Write-Host "Inventario generado correctamente en $exportPath"
    Write-Log -Level "INFO" -Message "Inventario generado correctamente en $exportPath"
} catch {
    Write-Warning "Error al exportar CSV: $_"
    Write-Log -Level "ERROR" -Message "Error al exportar CSV: $_"
    throw "No se pudo guardar el CSV."
}

Write-Host "Resumen: Inventario disponible en $exportPath"
Write-Log -Level "INFO" -Message "Resumen final: Inventario disponible en $exportPath"

