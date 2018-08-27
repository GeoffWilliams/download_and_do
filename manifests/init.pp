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
# @param provider Shell provider to use (from module hiera data)
# @param file_owner Owner for directory used to cache files
# @param file_group Group for directory used to cache files
# @param path_separator Path separator character to use on this OS
# @param allow_insecure Disable certificate validation (from module hiera data)
# @param file_mode Mode for directory used to cache files
class download_and_do(
    Variant[String, Array[String]]  $path,
    String                          $base_dir,
    String                          $extract_dir,
    String                          $download_dir,
    String                          $provider,
    String                          $file_owner,
    Variant[Undef, String, Integer] $file_group,
    String                          $path_separator,
    Boolean                         $allow_insecure = false,
    String                          $file_mode      = "0755",
) {

  file { [$base_dir, $extract_dir, $download_dir]:
    ensure => directory,
    owner  => $file_owner,
    group  => $file_group,
    mode   => $file_mode,
  }

}
