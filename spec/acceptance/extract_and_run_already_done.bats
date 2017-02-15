@test "downloaded file retained (1)" {
  grep "mine" /var/cache/download_and_do/download/test.tar.gz
}

@test "downloaded file retained (2)" {
  grep "mine"  /var/cache/download_and_do/download/test2.tar.gz
}

@test "command not run" {
  grep "mine" /extract_and_run_test
}
