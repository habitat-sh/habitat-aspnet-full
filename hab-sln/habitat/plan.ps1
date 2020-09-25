$pkg_name="hab-sln"
$pkg_origin="mwrock"
$pkg_version="0.1.0"
$pkg_maintainer="Matt Wrock"
$pkg_license=@('MIT')
$pkg_description="A sample ASP.NET Full FX IIS app"
$pkg_deps=@(
  "core/dotnet-472-runtime",
  "core/iis-webserverrole",
  "core/iis-aspnet4",
  "core/dsc-core"
)
$pkg_build_deps=@(
  "core/dotnet-472-dev-pack",
  "mwrock/visual-build-tools-2019/16.7.3/20200925115314"
)
$pkg_exposes=@('port')
$pkg_exports=@{
  "port"="port"
}

function Invoke-Build {
  Copy-Item $PLAN_CONTEXT/../../* $HAB_CACHE_SRC_PATH/$pkg_dirname -recurse -force
  MSBuild $HAB_CACHE_SRC_PATH/$pkg_dirname/$pkg_name/${pkg_name}.csproj /t:Build /restore
  if($LASTEXITCODE -ne 0) {
      Write-Error "dotnet build failed!"
  }
}

function Invoke-Install {
  # $env:VSToolsPath = "$(Get-HabPackagePath visual-build-tools-2019)\Contents\MSBuild\Microsoft\VisualStudio\v16.0"
  MSBuild $HAB_CACHE_SRC_PATH/$pkg_dirname/$pkg_name/${pkg_name}.csproj /t:WebPublish /p:WebPublishMethod=FileSystem /p:publishUrl=$pkg_prefix/www # /v:diag > c:\src\log.txt
}
