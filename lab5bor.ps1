Clear-Host

$surname = Read-Host 'Set your Surname'

function Get-Codes([string]$Surname) {
    
    $codes = @{}
    $counter = 0

    foreach ($char in $Surname.ToCharArray()) {
        
        if( -Not ($codes.ContainsKey($char))) {
            $codes.add( $char, [string]$counter )
            $counter++
        }

    }

    return [hashtable]$codes

}

function Get-Text([string]$FileName) {
    
    $content = Get-Content $FileName
    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $True
    [System.IO.File]::WriteAllLines($FileName, $content, $Utf8NoBomEncoding)

    return $content

}

function File-Encode([string]$Surname, [hashtable]$code) {
    
    $filename = 'D:\university\4курс\powershell\lukomorie.txt'

    $code = Get-Codes($surname)
    $content = Get-Text($filename)
    
    foreach ($key in $code.Keys) {
        $content = $content.replace([char]$key, [char]$code[$key])
    }

    $content > 'D:\university\4курс\powershell\encode.txt'
    
}
function File-Decode([string]$Surname, [hashtable]$code) {

    $filename = 'D:\university\4курс\powershell\lukomorie.txt'

    $code = Get-Codes($surname)
    $content = Get-Text($filename)
    
    foreach ($key in $code.Keys) {
        $content = $content.replace([char]$code[$key], [char]$key)
    }

    $content > 'D:\university\4курс\powershell\decode.txt'

}

$codes = Get-Codes($surname)

$codes | Format-Table value


File-Encode($surname)
File-Decode($surname)