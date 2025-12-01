$carpetas = @("ASIR1", "ASIR2", "DAW1", "DAW2", "DAM1", "DAM2", "SMR1", "SMR2", "SMRd1", "SMRd2")
$raiz = "C:\carpetas\"
foreach ($grupo in $carpetas) {
    Write-Host "Creando clase $grupo"
    $carpetagrupo = $raiz + $grupo + "\"
    $directoriocreado = mkdir $carpetagrupo
    for ($nalumno = 1; $nalumno -le 20; $nalumno++) {
        $idalumno = $grupo + ("{0:D2}" -f $nalumno)
        Write-Host "--> Creando carpeta de $idalumno"
        $carpetaalumno = $carpetagrupo + $idalumno + "\"
        $directoriocreado = mkdir $carpetaalumno
    }
}