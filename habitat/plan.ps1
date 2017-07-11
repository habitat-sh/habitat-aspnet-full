$pkg_name="habitat-aspnet-full"
$pkg_origin="core"
$pkg_version="0.1.0"
$pkg_source="nosuchfile.tar.gz"
$pkg_upstream_url="https://github.com/mwrock/habitat-aspnet-full"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('MIT')
$pkg_description="A sample ASP.NET Full FX IIS app"
$pkg_build_deps=@("core/nuget")

function invoke-download { }
function invoke-verify { }

function Invoke-Build {
  Copy-Item $PLAN_CONTEXT/../* $HAB_CACHE_SRC_PATH/$pkg_dirname -recurse -force -Exclude ".vagrant"
  nuget restore $HAB_CACHE_SRC_PATH/$pkg_dirname/packages.config -PackagesDirectory $HAB_CACHE_SRC_PATH/$pkg_dirname/packages
  $env:SystemRoot\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe $HAB_CACHE_SRC_PATH/$pkg_dirname/habitat-aspnet-full.csproj /t:Build
  if($LASTEXITCODE -ne 0) {
      Write-Error "dotnet build failed!"
  }
}

function Invoke-Install {
  mkdir $pkg_prefix/www -Force
  Copy-Item $HAB_CACHE_SRC_PATH/$pkg_dirname/* "$pkg_prefix/www" -Recurse -Include @("bin", "content", "fonts", "scripts", "views", "global.asax", "favicon.ico", "web.config") 
}
