# Class: glusterfs::client
#
# GlusterFS client. See glusterfs::mount instead.
#
class glusterfs::client (
  $client_package_name = $::glusterfs::params::client_package_name,
) inherits glusterfs::params {

  package { 'glusterfs-fuse':
    ensure => installed,
    name   => $client_package_name,
  }

}

