# @PDQTest
include download_and_do
download_and_do::run { "test.sh":
  source  => "/testcase/spec/mock/test.sh",
  creates => "/alreadydone",

}

# second run to detect duplicate resources
download_and_do::run { "test2.sh":
  source  => "/testcase/spec/mock/test2.sh",
  creates => "/alreadydone",

}
