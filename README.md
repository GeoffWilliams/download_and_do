# download_and_do

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Download files using [puppet-archive](https://forge.puppet.com/puppet/archive), then either run directly or unpack and run a command.


## Usage

### Download, Extract, Run

```puppet
download_and_do::extract_and_run { "test.tar.gz":
  source       => "http://blah/cut/spec/fixtures/test.tar.gz",
  run_relative => "cp test.txt /extract_and_run",
}
```
Download from `source` to `title`, then perform the command at `run_relative`

### Download, Run
```
download_and_do::run { "test.sh":
  source => "http://blah/cut/spec/fixtures/test.sh"
}
```

Download from `source` to `title`, then make the local file executable and run it.

## Reference

### Classes
* `download_and_do` - Class to setup the module and general download directories.  Needs to be included first

### Defined types
* `download_and_do::run` - Defined resource type to download and run a file
* `Download_and_do::extract_and_run` - Defined resource type to download, extract and run a command


## Limitations

* Requires the puppet archive module
* Doesn't support proxies here (but puppet-archive does so should be possible)
* Not supported by Puppet, Inc.

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
