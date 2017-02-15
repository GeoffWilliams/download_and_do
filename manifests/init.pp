# Download_and_do
#
# Download_and_do base class for setting global parameters
class download_and_do(
    $path         = $download_and_do::params::path,
    $base_dir     = $download_and_do::params::base_dir,
    $extract_dir  = $download_and_do::params::extract_dir,
    $download_dir = $download_and_do::params::download_dir,
) inherits download_and_do::params {

  file { [$base_dir, $extract_dir, $download_dir]:
    ensure => directory,
    owner  => "root",
    group  => 0,
    mode   => "0755",
  }

}
