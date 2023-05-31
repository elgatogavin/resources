
Write-Host "Scanning devices..." -ForegroundColor Green

$str = (Get-PnpDevice -Class ElgatoUsbAudio_sc -PresentOnly -erroraction 'silentlycontinue').InstanceId | Select-String -Pattern PID_0070  -erroraction 'silentlycontinue'

if (-Not $str )
{
    $str = (Get-PnpDevice -Class USB -PresentOnly   -erroraction 'silentlycontinue').InstanceId | Select-String -Pattern PID_0070 
}
if ($str)
{
    Write-Host "`nWave:3 detected, determine Serialnumber..." -ForegroundColor Green 
    Start-Sleep -Seconds 1
    $idarray = $str -split "\\" 
    Write-Host "`n--> " $idarray[2] -ForegroundColor Green
    Start-Sleep -Seconds 1
    Write-Host "`nCopy serial-number to clipboard..." -ForegroundColor Green
    $idarray[2]  | Set-Clipboard
    Start-Sleep -Seconds 3
    # notepad.exe SerialNumber.txt
}
else
{
    # [System.Windows.MessageBox]::Show('Please connet Wave:3')
    Write-Host "`nPlease connect Wave:3" -ForegroundColor red 
    Start-Sleep -Seconds 1.5
}
