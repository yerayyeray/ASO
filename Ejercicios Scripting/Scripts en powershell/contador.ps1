$contador=9;
if($contador -eq 9) { $cuentapabajo= $true}
else { $cuentapabajo= $true}
$numerofilas=3; $numero=3; $numerocolumnas=3
for($fila=1; $fila -le $numerofilas;$fila ++)
{   $textofila=""
    for($columna=1; $columna -le $numerocolumnas; $columna++)
    {   $textofila= $textofila+ $contador +" "
        if ($cuentapabajo) {$contador--}
        else {$contador++}
    }
    write-host $textofila
}