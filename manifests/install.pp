# Service class for zeppelin

class zeppelin::install(
)inherits zeppelin::params{

  archive { "${home_dir}/${version}":
    ensure          => present,
    extract         => true,
    extract_path    => $home_dir,
    extract_command => 'tar xfz %s --strip-components=1',
    source          => "http://apache.rediris.es/zeppelin/zeppelin-${version}/${package}",
    cleanup         => true,
  } ->

  file { "${home_dir}/bin":
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
  }
}
