# Class: glusterfs::client
#
# GlusterFS client. See glusterfs::mount instead.
#
class glusterfs::client {

  require glusterfs::ppa

  package { 'glusterfs-client':
    ensure => installed,
  }

}

