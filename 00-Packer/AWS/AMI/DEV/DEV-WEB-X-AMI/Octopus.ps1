# Download Octopus Deploy Agent MSI and install it
$octopusUrl = "https://download.octopusdeploy.com/octopus/Octopus.Tentacle.6.2.277-x64.msi"
$octopusInstaller = "C:\OctopusTentacle.msi"
Invoke-WebRequest $octopusUrl -OutFile $octopusInstaller
Start-Process msiexec.exe -ArgumentList "/i $octopusInstaller /quiet" -Wait

# Install Octopus Deploy Tentacle
"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" create-instance --instance "Tentacle" --config "C:\Octopus\Tentacle.config"
"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" new-certificate --instance "Tentacle" --if-blank
"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" configure --instance "Tentacle" --reset-trust
"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" configure --instance "Tentacle" --app "C:\Octopus\Applications" --port "10933" --noListen "False"

##Leaked trust and rotated##
"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" configure --instance "Tentacle" --trust "5CA0B7EDF9EF2FE8A8DE95C8B95DAD4B3DA19C88"
"netsh" advfirewall firewall add rule "name=Octopus Deploy Tentacle" dir=in action=allow protocol=TCP localport=10933
"C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe" service --instance "Tentacle" --install --stop --start
