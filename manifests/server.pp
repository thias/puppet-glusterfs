# Class: glusterfs::server
#
# GlusterFS Server.
#
# Parameters:
#  $peers:
#    Array of peer IP addresses to be added. Default: empty
#
# Sample Usage :
#  class { 'glusterfs::server':
#    peers => $::hostname ? {
#      'server1' => '192.168.0.2',
#      'server2' => '192.168.0.1',
#    },
#  }
#
class glusterfs::server (
  $peers        = [],
  $service_name = $::glusterfs::params::service_name,
) inherits glusterfs::params {

  # Main package and service it provides
  package { 'glusterfs-server': ensure => installed }
  service { 'glusterd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    name      => $service_name,
    require   => Package['glusterfs-server'],
  }

  # Peers
  glusterfs::peer { $peers: }

}

