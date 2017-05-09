# Download_and_do::Params
#
# Params pattern
class download_and_do::params {
  $allow_insecure = false
  $base_dir       = "/var/cache/download_and_do"
  $download_dir   = "${base_dir}/download"
  $extract_dir    = "${base_dir}/extract"
  $path           = [
    '/usr/bin',
    '/bin',
    '/usr/sbin',
    '/sbin',
    '/usr/local/bin',
    '/usr/local/sbin'
  ]
  $provider       = 'shell'
}
