function playSound {
    param (
        [Parameter(Mandatory = $true)]
        [System.Array]
        $morse
    )
    $morse.toCharArray() |
        ForEach-Object {
            if ($_ -eq ".") {
                [console]::beep(575,180) #short sound
                write-host "." -NoNewline
                Start-Sleep -Milliseconds 180
            }
            elseif ($_ -eq "-") {
                [console]::beep(575,500) #long sound
                write-host "-" -NoNewline
                Start-Sleep -Milliseconds 500
                }
            else {
                    write-host "$_" -NoNewline
                    Start-Sleep -Milliseconds 300
                }
        }
}

$morseCodeTransform = import-csv "C:\Users\Riley\MorseCode.csv"
$text = Read-Host "Enter letters you'd like to translate to morse code"
$textUpper = $text.ToUpper()
$morseCode = $textUpper.toCharArray() |
                ForEach-Object {
                    $char = $_
                    $transformedMorse = $morseCodeTransform |
                                            Where-Object { $char -eq $_.name } |
                                                Select-Object -Property Morse -ExpandProperty Morse
                    $transformedMorse = $transformedMorse + " "
                    Write-Output $transformedMorse
                }
Write-Host $($morseCode -join "")
$playSound = Read-Host "Would you like to play the morse code?"
switch ($playSound) {
    "yes"   {playSound($morseCode)}
    "y"     {playSound($morseCode)}
    default {exit]}
}
