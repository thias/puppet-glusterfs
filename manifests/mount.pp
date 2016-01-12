# Define: glusterfs::mount
#
# Manage client-side GlusterFS mounts.
#
# Example Usage:
#  glusterfs::mount { '/var/www':
#    device => '192.168.12.1:/gv0',
#  }
#
define glusterfs::mount (
  $device,
  $options = 'defaults',
  $ensure  = 'mounted'
) {

  include glusterfs::client

  mount { $title:
    ensure  => $ensure,
    device  => $device,
    fstype  => 'glusterfs',
    options => $options,
    require => Package['glusterfs-client'],
  }

}

