# Init class for profile zeppelin

class zeppelin(

  String $zeppelin_mem      = '-Xms1024m -Xmx4g -XX:MaxPermSize=512m',
  String $zeppelin_intp_mem = '-Xms1024m -Xmx4g -XX:MaxPermSize=512m',
  Array  $interpreters      = ['spark'],

)inherits zeppelin::params{

  $params_zeppelin_env = {
    'zeppelin_mem'      => $zeppelin_mem,
    'zeppelin_intp_mem' => $zeppelin_intp_mem,
    'spark_home'        => $spark_home,
    'hadoop_conf_dir'   => $hadoop_conf_dir
  }

  $params_zeppelin_site = {
    'mvnrepo'  => $mvnrepo,
    's3bucket' => $s3bucket,
    's3user'   => $s3user,
    'storage'  => $storage,
  }

  $params_zeppelin_interpreter = {
    'mvnrepo'  => $mvnrepo,
  }

  $params_zeppelin_users = {
    'users'  => $users,
  }

  file { $home_dir :
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  } ->

  class { 'zeppelin::install': } ->

  class { 'zeppelin::service': } ->

  file { "${home_dir}/conf/zeppelin-env.sh" :
      mode    => '0640',
      content => epp("${module_name}/zeppelin-env.sh.epp", $params_zeppelin_env),
  } ->

  file { "${home_dir}/conf/zeppelin-site.xml" :
      mode    => '0640',
      content => epp("${module_name}/zeppelin-site.xml.epp", $params_zeppelin_site),
  } ->

  #file { "${home_dir}/conf/interpreter.json" :
  #    mode    => '0640',
  #    content => epp("${module_name}/interpreter.json.epp", $params_zeppelin_interpreter),
  #} ->

  file { "${home_dir}/conf/shiro.ini" :
      mode    => '0640',
      content => epp("${module_name}/shiro.ini.epp", $params_zeppelin_users),
  }

#  service { 'zeppelin':
#      ensure => 'running',
#  }

  $external_libraries.each |$name, $values| {
    file { "${home_dir}/lib/${name}":
      ensure => present,
      source => $values,
    }
  }
# Create interpreters
$interpreters.each |$name| {
  class { "zeppelin::interpreters::${name}": }
}



}
