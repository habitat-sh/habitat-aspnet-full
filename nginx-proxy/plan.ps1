$pkg_name="nginx-proxy"
$pkg_origin="mwrock"
$pkg_version="0.1.0"
$pkg_license=('MIT')
$pkg_deps=@("core/nginx")
$pkg_exports=@{port="port"}
$pkg_exposes=@('port')
$pkg_binds=@{"backend"="port"}
