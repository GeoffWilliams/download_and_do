# @WPDQTest
class { "download_and_do":
  provider => powershell,
}

download_and_do::run { "test.ps1":
  source       => "c:\\vagrant\\download_and_do\\spec\\mock\\test.ps1",
  download_dir => "c:\\windows\\temp\\download",
}

# second run to detect duplicate resources
download_and_do::run { "test2.ps1":
  source => "c:\\vagrant\\download_and_do\\spec\\mock\\test2.ps1",
}
