require 'spec_helper'
require 'shared_contexts'

describe 'zeppelin' do
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
      #:zeppelin_mem => "-Xms1024m -Xmx4g -XX:MaxPermSize=512m",
      #:zeppelin_intp_mem => "-Xms1024m -Xmx4g -XX:MaxPermSize=512m",
      #:interpreters => ["spark"],

    }
  end
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  
  it do
    is_expected.to contain_file("$home_dir")
        .with({
          "ensure" => "directory",
          "owner" => "root",
          "group" => "root",
          "mode" => "0755",
          "that_comes_before" => 'Class[zeppelin::install]', })
  end
    
  it do
    is_expected.to contain_class("zeppelin::install")
  end
    
  it do
    is_expected.to contain_class("zeppelin::service")
  end
    
  it do
    is_expected.to contain_file("$home_dir/conf/zeppelin-env.sh")
        .with({
          "mode" => "0640",
          "content" => [],
          })
  end
    
  it do
    is_expected.to contain_file("$home_dir/conf/zeppelin-site.xml")
        .with({
          "mode" => "0640",
          "content" => [],
          })
  end
    
  it do
    is_expected.to contain_file("$home_dir/conf/shiro.ini")
        .with({
          "mode" => "0640",
          "content" => [],
          })
  end
    
  it do
    is_expected.to contain_file("$home_dir/lib/$name")
        .with({
          "ensure" => "present",
          "source" => "$values",
          })
  end
    
  it do
    is_expected.to contain_class("zeppelin::interpreters::$name")
  end
    
end
