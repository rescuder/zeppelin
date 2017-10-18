require 'spec_helper'
require 'shared_contexts'

describe 'zeppelin::interpreters::spark' do
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
      #:external_libraries => {},
      #:package => "spark-2.1.0",
      #:spark_dir => "/opt/spark-zeppelin",
      #:usehive => false,
      #:master => "yarn-client",

    }
  end
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  
  it do
    is_expected.to contain_file("/opt/spark-zeppelin")
        .with({
          "ensure" => "directory",
          "owner" => "root",
          "group" => "root",
          "mode" => "0755",
          "that_comes_before" => 'Archive[/opt/spark-zeppelin/spark2.0.tgz]', })
  end
    
  it do
    is_expected.to contain_archive("/opt/spark-zeppelin/spark2.0.tgz")
        .with({
          "ensure" => "present",
          "extract" => true,
          "extract_path" => "/opt/spark-zeppelin",
          "source" => "https://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz",
          "cleanup" => true,
          "that_requires" => 'File[/opt/spark-zeppelin]', })
  end
    
  it do
    is_expected.to contain_file("/opt/spark-zeppelin/$name")
        .with({
          "ensure" => "present",
          "source" => "$values",
          })
  end
    
end
