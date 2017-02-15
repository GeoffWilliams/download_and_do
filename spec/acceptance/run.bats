@test "downloaded OK" {
  test -f "/var/cache/download_and_do/download/test.sh"
}

@test "command ran OK" {
  grep "worked" /run_test
}

@test "downloaded OK (2)" {
  test -f "/var/cache/download_and_do/download/test2.sh"
}

@test "command ran OK (2)" {
  grep "worked" /run2_test
}
