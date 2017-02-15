require 'spec_helper'
describe 'download_and_do::extract_and_run', :type => :define do
  let :pre_condition do
    'include download_and_do'
  end
  context 'compiles when invoked correctly' do
    let :title do
      "test"
    end
    let :params do
      {
        :source       => '/foo/bar',
        :run_relative => '/bin/ls',
      }
    end
    it { should compile }
  end
end
