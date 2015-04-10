# Set default values here that are different accross OSes
class glusterfs::params {

  case $::osfamily {
    'Debian': {
      $service_name = 'glusterfs-server'
    }
    default, 'RedHat': {
      $service_name = 'glusterd'
    }
  }
}
