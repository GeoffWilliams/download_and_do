# Download_and_do
#
# Download_and_do base class to make download directories and for for setting default resource
# parameters
#
# Parameters on this class become defaults for download_and_do::run and
# download_and_do::extract_and_run defined resource types.  See those classes
# for a detailed explanation
#
# @param path PATH variable to use when running commands (from module hiera data)
# @param base_dir Parent directory for downloaded files (from module hiera data)
# @param extract_dir Directory to extract archives in (from module hiera data)
# @param download_dir Directory to download files to (from module hiera data)
# @param allow_insecure Disable certificate validation (from module hiera data)
# @param provider Shell provider to use (from module hiera data)
class download_and_do(
    $path,
    $base_dir,
    $extract_dir,
    $download_dir,
    $allow_insecure,
    $provider,
) {

  file { [$base_dir, $extract_dir, $download_dir]:
    ensure => directory,
    owner  => "root",
    group  => 0,
    mode   => "0755",
  }

}
