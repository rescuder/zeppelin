require 'spec_helper'
require 'shared_contexts'

describe 'zeppelin::params' do
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
      #:home_dir => "/opt/zeppelin",
      #:spark_home => "/opt/spark",
      #:hadoop_conf_dir => "/etc/hadoop/conf/",
      #:version => "zeppelin-0.7.2-bin-all.tgz",
      #:mvnrepo => "http://dualstack.internal-stg-repo-artifactory-1163003571.us-east-1.elb.amazonaws.com/artifactory/zeppelin/",
      #:s3bucket => "bi-zeppelin-notebook",
      #:s3user => "",
      #:storage => "org.apache.zeppelin.notebook.repo.S3NotebookRepo",
      #:cloudera_manager => false,
      #:users => {},

    }
  end
  # add these two lines in a single test block to enable puppet and hiera debug mode
  # Puppet::Util::Log.level = :debug
  # Puppet::Util::Log.newdestination(:console)
  
end
