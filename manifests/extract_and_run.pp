# Download_and_do::Run
#
# Download a file, extract it and then run a command.
#
# Perfect for things like downloadable tarballs containing RPMs to install.
# The downloaded archive will be retained after running.  Use the checksum to force
# a local update and reinstall
#
# @param source Location to download archive from
# @param download_dir Directory to download archive to
# @param local_file Where to save the file (inside $download_dir)
# @param extract_dir Directory to extract archive to
# @param checksum Checksum of local archive file to see if update needed (SHA1)
# @param run_relative Commands to run (relative to Extract dir) after downloading
# @param path PATH (array) to use when running command after extraction
define download_and_do::extract_and_run(
    $source,
    $run_relative,
    $local_file     = $title,
    $download_dir   = $download_and_do::download_dir,
    $extract_dir    = $download_and_do::extract_dir,
    $checksum       = undef,
    $path           = $download_and_do::path,
) {

  $run_relative_exec  = "run_relative after install ${title}"
  $local_file_path    = "${download_dir}/${local_file}"

  if $checksum {
    $checksum_type = "sha1"
  } else {
    $checksum_type = undef
  }

  archive { $local_file_path:
    ensure        => present,
    extract       => true,
    extract_path  => $extract_dir,
    source        => $source,
    checksum      => $checksum,
    checksum_type => $checksum_type,
    cleanup       => true,
    notify        => Exec[$run_relative_exec]
  }


  exec { $run_relative_exec:
    command     => "cd ${extract_dir} && ${run_relative}",
    refreshonly => true,
    path        => $path,
  }
}
