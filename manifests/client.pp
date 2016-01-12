# Class: glusterfs::client
#
# GlusterFS client. See glusterfs::mount instead.
#
class glusterfs::client {

  package { 'glusterfs-client': ensure => installed }

}

