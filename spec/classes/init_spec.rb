require 'spec_helper'
describe 'download_and_do' do
  context 'with default values for all parameters' do
    it { should contain_class('download_and_do') }
  end
end
