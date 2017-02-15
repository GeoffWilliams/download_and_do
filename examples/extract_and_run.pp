# @PDQTest
include download_and_do
download_and_do::extract_and_run { "test.tar.gz":
  source       => "/cut/spec/fixtures/test.tar.gz",
  run_relative => "cp test.txt /extract_and_run_test",
}

# second run to detect duplicate resources
download_and_do::extract_and_run { "test2.tar.gz":
  source       => "/cut/spec/fixtures/test2.tar.gz",
  run_relative => "ls",
}
