# elelvate script so network adapters can be disabled
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}


# get list of network adapters and disable them
Get-NetAdapter | Disable-NetAdapter -Confirm:$false
# open composer
& "C:\Program Files (x86)\Control4\Composer\Pro\ComposerPro.exe"
# wait
Start-Sleep -s 5
# re-enable network adapters
Get-NetAdapter | Enable-NetAdapter -Confirm:$false