# Download_and_do
#
# Download_and_do base class for setting global parameters
#
# Parameters on this class become defaults for download_and_do::run and
# download_and_do::extract_and_run defined resource types.  See those classes
# for a detailed explanation
class download_and_do(
    $path           = $download_and_do::params::path,
    $base_dir       = $download_and_do::params::base_dir,
    $extract_dir    = $download_and_do::params::extract_dir,
    $download_dir   = $download_and_do::params::download_dir,
    $allow_insecure = $download_and_do::params::allow_insecure,
) inherits download_and_do::params {

  file { [$base_dir, $extract_dir, $download_dir]:
    ensure => directory,
    owner  => "root",
    group  => 0,
    mode   => "0755",
  }

}
