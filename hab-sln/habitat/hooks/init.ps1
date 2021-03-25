if(Test-Connection -TCPPort {{cfg.port}} -TargetName 127.0.0.1) {
    Write-Host "{{pkg.name}} is stoping..."
    ."$env:SystemRoot\System32\inetsrv\appcmd.exe" stop apppool "{{cfg.app_pool}}"
    ."$env:SystemRoot\System32\inetsrv\appcmd.exe" stop site "{{cfg.site_name}}"
    Write-Host "{{pkg.name}} has stopped" 
}

# We create a symlink {{pkg.svc_var_path}} pointing to our package www folder.
# This is useful because if we update the application, we do not have to shut down
# the IIS site, repoint the "PhysicalPath" and then re start the site.
Set-Location {{pkg.svc_path}}
if(Test-Path var) { Remove-Item var -Recurse -Force }
New-Item -Name var -ItemType Junction -target "{{pkg.path}}/www" | Out-Null
