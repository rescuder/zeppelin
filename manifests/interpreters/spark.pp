# Install and manage spark interpreter for zeppelin

class zeppelin::interpreters::spark (
  Optional[Hash]    $external_libraries  = {'postgresql-42.0.0.jar'          => 'https://jdbc.postgresql.org/download/postgresql-42.0.0.jar',
                                            'mysql-connector-java-6.0.5.jar' => 'http://central.maven.org/maven2/mysql/mysql-connector-java/6.0.5/mysql-connector-java-6.0.5.jar',
                                            },
  String            $package             = 'spark-2.1.0',
  String            $spark_dir           = '/opt/spark-zeppelin',
  Boolean           $usehive             =  false,
  String            $master              = 'yarn-client',

)
{
    file { "${spark_dir}":
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    } ->

    archive { "${spark_dir}/spark2.0.tgz":
      ensure       => present,
      extract      => true,
      extract_path => $spark_dir,
      source       => "https://d3kbcqa49mib13.cloudfront.net/${package}-bin-hadoop2.7.tgz",
      cleanup      => true,
      }

      $external_libraries.each |$name, $values| {
        file { "${spark_dir}/${name}":
          ensure => present,
          source => $values,
        }
      }

}
