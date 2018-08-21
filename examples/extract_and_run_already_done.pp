# @PDQTest
include download_and_do
download_and_do::extract_and_run { "test.tar.gz":
  source       => "/testcase/spec/mock/test.tar.gz",
  run_relative => "cp test.txt /extract_and_run_test",
  creates      => "/alreadydone",
}

# second run to detect duplicate resources
download_and_do::extract_and_run { "test2.tar.gz":
  source       => "/testcase/spec/mock/test2.tar.gz",
  run_relative => "ls",
  creates      => "/alreadydone",
}
