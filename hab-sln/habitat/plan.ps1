$pkg_name="hab-sln"
$pkg_origin="mwrock"
$pkg_version="0.2.0"
$pkg_maintainer="Matt Wrock"
$pkg_license=@('MIT')
$pkg_description="A sample ASP.NET Full FX IIS app"
$pkg_deps=@(
  "core/dotnet-472-runtime",
  "core/iis-aspnet4",
  "core/dsc-core"
)
$pkg_build_deps=@(
  "core/dotnet-472-dev-pack",
  "core/nuget",
  "core/visual-build-tools-2019"
)
$pkg_exposes=@('port')
$pkg_exports=@{
  "port"="port"
}

function Invoke-Build {
  Copy-Item $PLAN_CONTEXT/../../* $HAB_CACHE_SRC_PATH/$pkg_dirname -recurse -force
  nuget restore $HAB_CACHE_SRC_PATH/$pkg_dirname/$pkg_name/packages.config -PackagesDirectory $HAB_CACHE_SRC_PATH/$pkg_dirname/packages -Source "https://www.nuget.org/api/v2"
  MSBuild $HAB_CACHE_SRC_PATH/$pkg_dirname/$pkg_name/${pkg_name}.csproj /t:Build
  if($LASTEXITCODE -ne 0) {
      Write-Error "dotnet build failed!"
  }
}

function Invoke-Install {
  MSBuild $HAB_CACHE_SRC_PATH/$pkg_dirname/$pkg_name/${pkg_name}.csproj /t:WebPublish /p:WebPublishMethod=FileSystem /p:publishUrl=$pkg_prefix/www
  (Get-Content "$pkg_prefix/www/views/home/Index.cshtml").replace("ASP.NET and IIS on Habitat!", "ASP.NET and IIS on Habitat! - $pkg_version/$pkg_release") | Set-Content "$pkg_prefix/www/views/home/Index.cshtml"
}
