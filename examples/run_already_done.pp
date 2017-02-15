# @PDQTest
include download_and_do
download_and_do::run { "test.sh":
  source  => "/cut/spec/fixtures/test.sh",
  creates => "/alreadydone",

}

# second run to detect duplicate resources
download_and_do::run { "test2.sh":
  source  => "/cut/spec/fixtures/test2.sh",
  creates => "/alreadydone",

}
