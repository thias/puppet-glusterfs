# Class: glusterfs::client
#
# GlusterFS client. See glusterfs::mount instead.
#
class glusterfs::client {

  package { 'glusterfs-fuse':
    ensure => installed,
    name      => $::osfamily ? {
      debian  => 'glusterfs-client',
      default => 'glusterfs-fuse'
    }
  }

}

