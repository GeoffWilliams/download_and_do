@test "downloaded OK" {
  test -f "/usr/download/test.tar.gz"
}

@test "downloaded OK (2)" {
  test -f "/var/cache/download_and_do/download/test2.tar.gz"
}

@test "command ran OK" {
  grep "hello" /tmp/extract_and_run_test
}

@test "command ran as correct user" {
  [[ $(stat -c %U /tmp/extract_and_run_test) == "bob" ]]
}
