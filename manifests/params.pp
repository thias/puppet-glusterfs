# Set default values here that are different accross OSes
class glusterfs::params {

  case $::osfamily {
    'Debian': {
      $service_name        = 'glusterfs-server'
      $client_package_name = 'glusterfs-client'
    }
    default, 'RedHat': {
      $service_name        = 'glusterd'
      $client_package_name = 'glusterfs-fuse'
    }
  }
}
