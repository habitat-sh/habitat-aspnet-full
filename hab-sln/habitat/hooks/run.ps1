$ProgressPreference="SilentlyContinue"

Start-DscCore (Join-Path {{pkg.svc_config_path}} website.ps1) NewWebsite

try {
    Write-Host "http://{{sys.ip}}:{{cfg.port}}/{{cfg.app_name}} is running"
    $running = $true
    while($running) {
        Start-Sleep -Seconds 1
        $resp = Invoke-WebRequest "http://localhost:{{cfg.port}}/{{cfg.app_name}}" -Method Head
        if($resp.StatusCode -ne 200) { $running = $false }
    }
}
catch {
    Write-Host "{{pkg.name}} HEAD check failed"
}
finally {
    # Add any cleanup here which will run after supervisor stops the service
    Write-Host "{{pkg.name}} is stoping..."
    ."$env:SystemRoot\System32\inetsrv\appcmd.exe" stop apppool "{{cfg.app_pool}}"
    ."$env:SystemRoot\System32\inetsrv\appcmd.exe" stop site "{{cfg.site_name}}"
    Write-Host "{{pkg.name}} has stopped"
}
