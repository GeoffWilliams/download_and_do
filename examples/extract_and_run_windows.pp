# @WPDQTest
include download_and_do

file { ["c:\\download", "c:\\extract"]:
  ensure => directory,
  owner  => "Administrators",
}

# run something with powershell
download_and_do::extract_and_run { "test.zip":
  source       => "c:\\vagrant\\download_and_do\\spec\\mock\\test.zip",
  run_relative => "robocopy /S . c:\\windows\\temp ; powershell -file c:\\windows\\temp\\dd\\test.ps1",
  download_dir => "c:\\download",
  extract_dir  => "c:\\extract",
  cleanup      => false,
  provider     => powershell,
}

# second run to detect duplicate resources and test the cmd.exe command
download_and_do::extract_and_run { "test2.zip":
  source       => "c:\\vagrant\\download_and_do\\spec\\mock\\test2.zip",
  run_relative => "dir && dir",
}
