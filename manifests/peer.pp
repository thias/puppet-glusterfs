# Define: glusterfs::peer
#
# Simple "gluster peer probe" wrapper. Peers only need to be added on one end.
# Use the $peers option to the glusterfs::server class instead of this
# definition directly.
#
define glusterfs::peer () {

  $peer_dir = $::osfamily ? {
    debian  => '/etc/glusterd/peers',
    default => '/var/lib/glusterd/peers'
  }

  exec { "/usr/sbin/gluster peer probe ${title}":
    unless  => "/bin/egrep '^hostname.+=${title}$' ${peer_dir}/*",
    require => Service['glusterd'],
  }

}

