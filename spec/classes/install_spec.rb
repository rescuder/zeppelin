require 'spec_helper'
require 'shared_contexts'

describe 'zeppelin::install' do
  # by default the hiera integration uses hiera data from the shared_contexts.rb file
  # but basically to mock hiera you first need to add a key/value pair
  # to the specific context in the spec/shared_contexts.rb file
  # Note: you can only use a single hiera context per describe/context block
  # rspec-puppet does not allow you to swap out hiera data on a per test block
  #include_context :hiera

  # below is the facts hash that gives you the ability to mock
  # facts on a per describe/context block.  If you use a fact in your
  # manifest you should mock the facts below.
  let(:facts) do
    {}
  end

  # below is a list of the resource parameters that you can override.
  # By default all non-required parameters are commented out,
  # while all required parameters will require you to add a value
  let(:params) do
    {

    }
  end
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  
  it do
    is_expected.to contain_archive("$home_dir/$version")
        .with({
          "ensure" => "present",
          "extract" => true,
          "extract_path" => "$home_dir",
          "extract_command" => "tar xfz %s --strip-components=1",
          "source" => "http://apache.rediris.es/zeppelin/zeppelin-0.7.2/$version",
          "cleanup" => true,
          "that_comes_before" => 'File[$home_dir/bin]', })
  end
    
  it do
    is_expected.to contain_file("$home_dir/bin")
        .with({
          "ensure" => "directory",
          "owner" => "root",
          "group" => "root",
          "mode" => "0755",
          "recurse" => true,
          "that_requires" => 'Archive[$home_dir/$version]', })
  end
    
end
