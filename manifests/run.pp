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
define download_and_do::run(
  $source,
  $local_file   = $title,
  $download_dir = $download_and_do::download_dir,
  $path         = $download_and_do::path,
  $checksum     = undef,
  $creates      = undef,
) {

  $run_file_exec    = "run after download ${title}"
  $local_file_path  = "${download_dir}/${local_file}"

  if $checksum {
    $checksum_type = "sha1"
  } else {
    $checksum_type = undef
  }

  archive { $local_file_path:
    ensure        => present,
    extract       => false,
    path          => $local_file_path,
    source        => $source,
    checksum      => $checksum,
    checksum_type => $checksum_type,
    creates       => $creates,
    notify        => Exec[$run_file_exec]
  }

  exec { $run_file_exec:
    command     => "chmod +x ${local_file_path} && ${local_file_path}",
    refreshonly => true,
    path        => $path,
    creates     => $creates,
  }

}
