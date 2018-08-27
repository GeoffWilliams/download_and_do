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
# @param user User for file ownership and to run command (not supported on windows)
# @param group Group for file ownership
# @param environment Environment variables (BASH) to run command with
# @param arguments Arguments to pass to the downloaded file to be run
# @param allow_insecure Allow insecure HTTPS downloads
# @param provider Set the exec provider - needed as `cd` is a builtin. On windows you will need to set
#   `powershell` if you are attempting to download and execute powershell
# @param timeout How long to wait before killing command we were told to run, in seconds.
#   Pass `0` to wait upto forever seconds for the command to complete
# @param proxy_server specify a proxy server, with port number if needed. ie: https://example.com:8080.
# @param proxy_type proxy server type (none|http|https|ftp)
define download_and_do::run(
  String                                    $source,
  String                                    $local_file     = $title,
  String                                    $download_dir   = $download_and_do::download_dir,
  Variant[String, Array[String]]            $path           = $download_and_do::path,
  Optional[String]                          $checksum       = undef,
  Optional[String]                          $creates        = undef,
  Optional[String]                          $unless         = undef,
  Optional[String]                          $onlyif         = undef,
  Optional[String]                          $user           = undef,
  Optional[String]                          $group          = undef,
  Optional[Variant[String, Array[String]]]  $environment    = undef,
  String                                    $arguments      = "",
  Boolean                                   $allow_insecure = $download_and_do::allow_insecure,
  String                                    $provider       = $download_and_do::provider,
  Optional[Integer]                         $timeout        = undef,
  Optional[String]                          $proxy_server   = undef,
  Optional[String]                          $proxy_type     = undef,
  String                                    $path_separator = $download_and_do::path_separator,
) {

  $chmod_file_exec      = "chmod after download ${title}"
  $run_file_exec        = "run after download ${title}"
  $local_file_path      = "${download_dir}${path_separator}${local_file}"
  $after_download_exec  = $facts["os"]["family"] ? {
    "windows" => $run_file_exec,
    default   => $chmod_file_exec
  }

  if $checksum {
    $checksum_type = "sha1"
  } else {
    $checksum_type = undef
  }

  if $user and $facts['os']['family'] == "windows" {
    fail("Running as different user not supported on windows")
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
    proxy_server   => $proxy_server,
    proxy_type     => $proxy_type,
    notify         => Exec[$after_download_exec],
  }

  # chmod +x the script so it can be run natively.  Separate exec due to being
  # done as root always (non-windows only)
  if $facts['os']['family'] != "windows" {
    exec { $chmod_file_exec:
      command     => "/bin/chmod +x ${local_file_path}",
      refreshonly => true,
      user        => "root",
      notify      => Exec[$run_file_exec],
    }
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
    provider    => $provider,
    timeout     => $timeout,
  }

}
