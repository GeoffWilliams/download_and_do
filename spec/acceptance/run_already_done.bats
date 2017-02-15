@test "downloaded file retained (1)" {
  grep "mine" /var/cache/download_and_do/download/test.sh
}

@test "downloaded file retained (2)" {
  grep "mine"  /var/cache/download_and_do/download/test2.sh
}

@test "command not run (1)" {
  grep "mine" /run_test
}

@test "command not run (2)" {
  grep "worked" /run2_test
}
