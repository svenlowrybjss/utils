oh-my-posh --init --shell pwsh --config '\\wsl$\Ubuntu-22.04\home\sven\projects\personal\utils\configs\oh-my-posh\omp.json' | Invoke-Expression

# Terminal Icons
if (-Not (Get-Module -ListAvailable -Name "Terminal-Icons")) {
    Install-Module -Name "Terminal-Icons" -Repository PSGallery
}
Import-Module -Name Terminal-Icons

#PSReadLine
if (-Not (Get-Module -ListAvailable -Name "PSReadLine")) {
    Install-Module -Name "PSReadLine" -AllowPrerelease -Force
}
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

wsl.exe -d wsl-vpnkit service wsl-vpnkit start

Clear-Host
