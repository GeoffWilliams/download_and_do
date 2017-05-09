# Download_and_do::Run
#
# Download a file, extract it and then run a command.
#
# Perfect for things like downloadable tarballs containing RPMs to install.
# The downloaded archive will be retained after running.  Use the checksum to force
# a local update and reinstall
#
# @param source Location to download archive from
# @param download_dir Directory to download archive to if not using module default
# @param local_file Where to save the file (inside $download_dir)
# @param extract_dir Directory to extract archive to
# @param checksum Checksum of local archive file to see if update needed (SHA1)
# @param run_relative Commands to run (relative to Extract dir) after downloading
# @param path PATH (array) to use when running command after extraction
# @param creates Presence of this file indicates we do not need to download or
#   execute anything
# @param unless Pass-through parameter to exec to control whether to run or not
# @param onlyif Pass-through parameter to exec to control whether to run or not
# @param user User for file ownership and to run command with
# @param group Group for file ownership
# @param environment Environment variables (BASH) to run command with
# @param allow_insecure Allow insecure HTTPS downloads
# @param provider Set the exec provider - needed if `cd` is a builtin
# @param How long to wait before killing command we were told to run, in seconds.
#   Pass `0` to wait upto forever seconds for the command to complete
define download_and_do::extract_and_run(
    $source,
    $run_relative,
    $local_file     = $title,
    $download_dir   = $download_and_do::download_dir,
    $extract_dir    = $download_and_do::extract_dir,
    $checksum       = undef,
    $path           = $download_and_do::path,
    $creates        = undef,
    $unless         = undef,
    $onlyif         = undef,
    $user           = undef,
    $group          = undef,
    $environment    = undef,
    $allow_insecure = $download_and_do::allow_insecure,
    $provider       = $download_and_do::provider,
    $timeout        = undef,
) {

  $run_relative_exec  = "run_relative after install ${title}"
  $local_file_path    = "${download_dir}/${local_file}"

  if $checksum {
    $checksum_type = "sha1"
  } else {
    $checksum_type = undef
  }

  archive { $local_file_path:
    ensure         => present,
    extract        => true,
    extract_path   => $extract_dir,
    source         => $source,
    checksum       => $checksum,
    checksum_type  => $checksum_type,
    cleanup        => true,
    creates        => $creates,
    user           => $user,
    group          => $group,
    allow_insecure => $allow_insecure,
    notify         => Exec[$run_relative_exec]
  }


  exec { $run_relative_exec:
    command     => "cd ${extract_dir} && ${run_relative}",
    refreshonly => true,
    creates     => $creates,
    unless      => $unless,
    onlyif      => $onlyif,
    path        => $path,
    user        => $user,
    environment => $environment,
    provider    => $provider,
    timeout     => $timeout,
  }
}
