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
  $options = 'defaults,_netdev',
  $fstype  = 'glusterfs',
  $ensure  = 'mounted'
) {

  include glusterfs::client

  if $fstype == 'glusterfs' {
    mount { $title:
      ensure  => $ensure,
      device  => $device,
      fstype  => $fstype,
      options => $options,
      require => Package['glusterfs-fuse'],
    }
  }
  elseif $fstype == 'nfs' {
    mount { $title:
      ensure  => $ensure,
      device  => $device,
      fstype  => $fstype,
      options => $options,
    }
  }
  else {
    fail("$fstype is not a valid filesystem for gluster")
  }
}

