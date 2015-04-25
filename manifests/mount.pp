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
  $path    = $name,
  $options = 'defaults,_netdev',
  $fstype  = 'glusterfs',
  $ensure  = 'mounted'
) {

  include glusterfs::client

  if $fstype == 'glusterfs' {
    mount { $path:
      ensure   => $ensure,
      device   => $device,
      fstype   => $fstype,
      options  => $options,
      remounts => false,
      require  => Package['glusterfs-fuse'],
    }
  }
  elsif $fstype == 'nfs' {
    mount { $path:
      ensure   => $ensure,
      device   => $device,
      fstype   => $fstype,
      remounts => false,
      options  => $options,
    }
  }
  else {
    fail("${fstype} is not a valid filesystem for gluster")
  }
}
