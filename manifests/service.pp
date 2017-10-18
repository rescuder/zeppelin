# Service class for zeppelin

class zeppelin::service(
){

  case $::osfamily {
    'Debian': {
      file { '/etc/init.d/zeppelin':
          mode    => '0755',
          content => epp("${module_name}/zeppelin.init.d.epp"),
          notify  => Exec['/usr/sbin/update-rc.d zeppelin defaults'],
      }
      exec { '/usr/sbin/update-rc.d zeppelin defaults':
          refreshonly => true,
      }
    }
    'RedHat': {
      file { '/etc/init.d/zeppelin':
          mode    => '0755',
          content => epp("${module_name}/zeppelin.init.d.epp"),
          notify  => Exec['/sbin/chkconfig --levels 2345 zeppelin'],
      }
      exec { '/sbin/chkconfig --levels 2345 zeppelin':
          refreshonly => true,
      }
    }
  }
}
