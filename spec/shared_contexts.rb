# optional, this should be the path to where the hiera data config file is in this repo
# You must update this if your actual hiera data lives inside your module.
# I only assume you have a separate repository for hieradata and its include in your .fixtures
hiera_config_file = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures','modules','hieradata', 'hiera.yaml'))

# hiera_config and hiera_data are mutually exclusive contexts.

shared_context :global_hiera_data do
  let(:hiera_data) do
     {
       #"zeppelin::interpreters" => '',
       #"zeppelin::interpreters::spark::external_libraries" => '',
       #"zeppelin::interpreters::spark::master" => '',
       #"zeppelin::interpreters::spark::package" => '',
       #"zeppelin::interpreters::spark::spark_dir" => '',
       #"zeppelin::interpreters::spark::usehive" => '',
       #"zeppelin::params::cloudera_manager" => '',
       #"zeppelin::params::external_libraries" => '',
       #"zeppelin::params::hadoop_conf_dir" => '',
       #"zeppelin::params::home_dir" => '',
       #"zeppelin::params::mvnrepo" => '',
       #"zeppelin::params::s3bucket" => '',
       #"zeppelin::params::s3user" => '',
       #"zeppelin::params::spark_home" => '',
       #"zeppelin::params::storage" => '',
       #"zeppelin::params::users" => '',
       #"zeppelin::params::version" => '',
       #"zeppelin::zeppelin_intp_mem" => '',
       #"zeppelin::zeppelin_mem" => '',
     
     }
  end
end

shared_context :hiera do
    # example only,
    let(:hiera_data) do
        {:some_key => "some_value" }
    end
end

shared_context :linux_hiera do
    # example only,
    let(:hiera_data) do
        {:some_key => "some_value" }
    end
end

# In case you want a more specific set of mocked hiera data for windows
shared_context :windows_hiera do
    # example only,
    let(:hiera_data) do
        {:some_key => "some_value" }
    end
end

# you cannot use this in addition to any of the hiera_data contexts above
shared_context :real_hiera_data do
    let(:hiera_config) do
       hiera_config_file
    end
end
