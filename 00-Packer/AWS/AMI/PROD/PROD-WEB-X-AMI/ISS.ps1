# Function to enable features with error checking
function Enable-WindowsFeatureIfNotEnabled {
    param (
        [string]$FeatureName
    )

    $feature = Get-WindowsOptionalFeature -Online -FeatureName $FeatureName
    if ($feature.State -ne "Enabled") {
        Enable-WindowsOptionalFeature -Online -FeatureName $FeatureName
    }
}

# Install dependencies
dism /online /Enable-Feature /FeatureName:NetFx4 /All

# Enable IIS features
$iisFeatures = @(
    "IIS-WebServerRole", "IIS-WebServer", "IIS-CommonHttpFeatures", "IIS-Security", "IIS-RequestFiltering", "IIS-StaticContent",
    "IIS-DefaultDocument", "IIS-DirectoryBrowsing", "IIS-HttpErrors", "IIS-ApplicationDevelopment", "IIS-WebSockets", "IIS-ApplicationInit",
    "IIS-ISAPIExtensions", "IIS-ISAPIFilter", "IIS-ServerSideIncludes", "IIS-HealthAndDiagnostics",
    "IIS-HttpLogging", "IIS-Performance", "IIS-HttpCompressionStatic", "IIS-WebServerManagementTools", "IIS-ManagementConsole", "IIS-ManagementService"
)

foreach ($feature in $iisFeatures) {
    Enable-WindowsFeatureIfNotEnabled -FeatureName $feature
}

# Install ASP dependencies
Enable-WindowsFeatureIfNotEnabled -FeatureName "IIS-ASPNET45"

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# # Install WebDeploy # Part of demo pre octopus
# choco install webdeploy -y

# Install .NET Hosting Bundle
$dotNetHostingUrl = "https://download.visualstudio.microsoft.com/download/pr/321a2352-a7aa-492a-bd0d-491a963de7cc/6d17be7b07b8bc22db898db0ff37a5cc/dotnet-hosting-6.0.14-win.exe"
$dotNetHostingFile = "dotnet-hosting-6.0.14-win.exe"
Invoke-WebRequest -Uri $dotNetHostingUrl -OutFile $dotNetHostingFile
Start-Process $dotNetHostingFile "/install /quiet" -Wait

# Restart IIS
Restart-Service -Name W3SVC
