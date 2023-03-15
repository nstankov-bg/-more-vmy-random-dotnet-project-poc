# Download Octopus Deploy Agent MSI and install it
$octopusUrl = "https://download.octopusdeploy.com/octopus/Octopus.Tentacle.6.2.277-x64.msi"
$octopusInstaller = "C:\OctopusTentacle.msi"
Invoke-WebRequest $octopusUrl -OutFile $octopusInstaller
Start-Process msiexec.exe -ArgumentList "/i $octopusInstaller /quiet" -Wait

# Install Octopus Deploy Tentacle
$tentaclePath = "C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe"
$instanceName = "Tentacle"
$configPath = "C:\Octopus\Tentacle.config"
$appPath = "C:\Octopus\Applications"
$port = "10933"

& $tentaclePath create-instance --instance $instanceName --config $configPath
& $tentaclePath new-certificate --instance $instanceName --if-blank
& $tentaclePath configure --instance $instanceName --reset-trust
& $tentaclePath configure --instance $instanceName --app $appPath --port $port --noListen "False"

# Store the trusted thumbprint in an environment variable or a secrets manager
$thumbprint = Get-Content 'C:\path\to\thumbprint.txt'

& $tentaclePath configure --instance $instanceName --trust $thumbprint
netsh advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=$port
& $tentaclePath service --instance $instanceName --install --stop --start
