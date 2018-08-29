# download_and_do

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Download files using [puppet-archive](https://forge.puppet.com/puppet/archive), then either run directly or unpack and run a command.


## Usage

### Download, Extract, Run

```puppet
include download_and_do
download_and_do::extract_and_run { "test.tar.gz":
  source       => "http://blah/cut/spec/fixtures/test.tar.gz",
  run_relative => "cp test.txt /extract_and_run",
}
```
Download from `source` to `title`, then perform the command at `run_relative`.  Pass the `creates` parameter to specify the presence of a file that means that the resource is already converged.

Local filename is a unique relative path within download and do download directory `/var/cache/download_and_do`.


### Download, Run
```
include download_and_do
download_and_do::run { "test.sh":
  source => "http://blah/cut/spec/fixtures/test.sh"
}
```

Download from `source` to `title`, then make the local file executable and run it.  Pass the `creates` parameter to specify the presence of a file that means that the resource is already converged.

Local filename is a unique relative path within download and do download directory `/var/cache/download_and_do`.


## Limitations

* Requires the puppet archive module
* You may encounter errors with `download_and_do::extract_and_run` on windows due to shell quoting

## Development

PRs accepted :)

## Testing
This module supports testing using [PDQTest](https://github.com/GeoffWilliams/pdqtest).


Test can be executed with:

```
bundle install
bundle exec pdqtest all
```


See `.travis.yml` for a working CI example
