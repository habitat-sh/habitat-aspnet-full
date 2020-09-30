# We create a symlink {{pkg.svc_var_path}} pointing to our package www folder.
# This is useful because if we update the application, we do not have to shut down
# the IIS site, repoint the "PhysicalPath" and then re start the site.
Set-Location {{pkg.svc_path}}
if(Test-Path var) { Remove-Item var -Recurse -Force }
New-Item -Name var -ItemType Junction -target "{{pkg.path}}/www" | Out-Null
