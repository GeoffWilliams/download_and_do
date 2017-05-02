# Download_and_do::Run
#
# Download a file and then run it. Perfect for things like self-installing bash
# scripts.  The script will be retained after running.  Use the checksum to force
# a local update and reinstall
#
# @param source File to download
# @param local_file Where to save the file (inside $download_dir)
# @param download_dir Drectory to download to instead of module default
# @param path PATH to use for executing file
# @param checksum Checksum (SHA1) of file, used to detect updates
# @param creates Presence of this file indicates we do not need to download or
#   execute anything
# @param unless Pass-through parameter to exec to control whether to run or not
# @param onlyif Pass-through parameter to exec to control whether to run or not
# @param user User for file ownership and to run command with
# @param group Group for file ownership
# @param environment Environment variables (BASH) to run command with
# @param arguments Arguments to pass to the downloaded file to be run
# @param allow_insecure Allow insecure HTTPS downloads
define download_and_do::run(
  $source,
  $local_file     = $title,
  $download_dir   = $download_and_do::download_dir,
  $path           = $download_and_do::path,
  $checksum       = undef,
  $creates        = undef,
  $unless         = undef,
  $onlyif         = undef,
  $user           = undef,
  $group          = undef,
  $environment    = undef,
  $arguments      = "",
  $allow_insecure = $download_and_do::allow_insecure,
) {

  $chmod_file_exec  = "chmod after download ${title}"
  $run_file_exec    = "run after download ${title}"
  $local_file_path  = "${download_dir}/${local_file}"

  if $checksum {
    $checksum_type = "sha1"
  } else {
    $checksum_type = undef
  }

  # Download will always be owned by root, user parameter only for extract
  archive { $local_file_path:
    ensure         => present,
    extract        => false,
    path           => $local_file_path,
    source         => $source,
    checksum       => $checksum,
    checksum_type  => $checksum_type,
    creates        => $creates,
    group          => $group,
    allow_insecure => $allow_insecure,
    notify         => Exec[$chmod_file_exec]
  }

  # chmod +x the script so it can be run natively.  Separate exec due to being
  # done as root always
  exec { $chmod_file_exec:
    command     => "/bin/chmod +x ${local_file_path}",
    refreshonly => true,
    user        => "root",
    notify      => Exec[$run_file_exec],
  }

  # Run the now-executable script if we need to
  exec { $run_file_exec:
    command     => "${local_file_path} ${arguments}",
    refreshonly => true,
    path        => $path,
    creates     => $creates,
    unless      => $unless,
    onlyif      => $onlyif,
    user        => $user,
    environment => $environment,
  }

}
