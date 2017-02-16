@test "downloaded OK" {
  test -f "/usr/download/test.sh"
}

@test "command ran OK" {
  grep "worked" /tmp/run_test
}

@test "command ran as correct user" {
  [[ $(stat -c %U /tmp/run_test) == "bob" ]]
}

@test "downloaded OK (2)" {
  test -f "/var/cache/download_and_do/download/test2.sh"
}

@test "command ran OK (2)" {
  grep "worked" /run2_test
}
