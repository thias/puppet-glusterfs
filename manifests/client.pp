# Class: glusterfs::client
#
# GlusterFS client. See glusterfs::mount instead.
#
class glusterfs::client {

  $package = $::osfamily ? {
      debian  => 'glusterfs-client',
      default => 'glusterfs-fuse'
  }

  package { 'glusterfs-fuse':
    ensure => installed,
    name      => $package
  }

}

