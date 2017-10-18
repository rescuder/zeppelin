# Service class for zeppelin

class zeppelin::params(
  Optional[Hash]    $external_libraries  = {'postgresql-42.0.0.jar'          => 'https://jdbc.postgresql.org/download/postgresql-42.0.0.jar',
                                            'mysql-connector-java-6.0.5.jar' => 'http://central.maven.org/maven2/mysql/mysql-connector-java/6.0.5/mysql-connector-java-6.0.5.jar',
                                            },
  String            $home_dir            = '/opt/zeppelin',
  String            $spark_home          = '/opt/spark',
  String            $hadoop_conf_dir     = '/etc/hadoop/conf/',
  String            $version             = '0.7.2',
  String            $package             = 'zeppelin-0.7.2-bin-all.tgz',
  String            $mvnrepo             = '',
  String            $s3bucket            = '',
  String            $s3user              = '',
  String            $storage             = '',
  Boolean           $cloudera_manager    = false,
  Optional[Hash]    $users               = {'admin' => 'admin'}
){

}
