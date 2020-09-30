Invoke-Command -ComputerName localhost -EnableNetworkAccess {
    $ProgressPreference="SilentlyContinue"
    Write-Host "Checking for nuget package provider..."
    if(!(Get-PackageProvider -Name nuget -ErrorAction SilentlyContinue -ListAvailable)) {
        Write-Host "Installing Nuget provider..."
        Install-PackageProvider -Name NuGet -Force | Out-Null
    }
    Write-Host "Checking for xWebAdministration PS module..."
    if(!(Get-Module xWebAdministration -ListAvailable)) {
        Write-Host "Installing xWebAdministration PS Module..."
        Install-Module xWebAdministration -Force | Out-Null
    }
}
