@test "downloaded OK" {
  test -f "/var/cache/download_and_do/download/test.tar.gz"
}

@test "downloaded OK (2)" {
  test -f "/var/cache/download_and_do/download/test2.tar.gz"
}

@test "command ran OK" {
  grep "hello" /extract_and_run_test
}
