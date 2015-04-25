# puppet-glusterfs

## Overview

Install, enable and configure GlusterFS.

* `glusterfs::server` : Class to install and enable the server.
* `glusterfs::peer` : Definition to add a server peer. Used by the server class' $peer parameter.
* `glusterfs::volume` : Definition to create server volumes.
* `glusterfs::client` : Class to install and enable the client. Included from the mount definition.
* `glusterfs::mount` : Definition to create client mounts.

You will need to open TCP ports 24007:24009 and 38465:38466 on the servers.

## Examples

Complete server with two redundant nodes, on top of existing kickstart
created vg0 LVM VGs. Note that the first runs will fail since the volume
creation won't work until the peers know each other, and that requires the
service to be running :

    file { [ '/export', '/export/gv0' ]:
      seltype => 'usr_t',
      ensure  => directory,
    }
    package { 'xfsprogs': ensure => installed }
    exec { 'lvcreate /dev/vg0/gv0':
      command => '/sbin/lvcreate -L 256G -n gv0 vg0',
      creates => '/dev/vg0/gv0',
      notify  => Exec['mkfs /dev/vg0/gv0'],
    }
    exec { 'mkfs /dev/vg0/gv0':
      command     => '/sbin/mkfs.xfs -i size=512 /dev/vg0/gv0',
      require     => [ Package['xfsprogs'], Exec['lvcreate /dev/vg0/gv0'] ],
      refreshonly => true,
    }
    mount { '/export/gv0':
      device  => '/dev/vg0/gv0',
      fstype  => 'xfs',
      options => 'defaults',
      ensure  => mounted,
      require => [ Exec['mkfs /dev/vg0/gv0'], File['/export/gv0'] ],
    }
    class { 'glusterfs::server':
      peers => $::hostname ? {
        'server1' => '192.168.0.2',
        'server2' => '192.168.0.1',
      },
    }
    glusterfs::volume { 'gv0':
      create_options => 'replica 2 192.168.0.1:/export/gv0 192.168.0.2:/export/gv0',
      require        => Mount['/export/gv0'],
    }

Client mount (the client class is included automatically). Note that clients
are virtual machines on the servers above, so make each of them use the replica
on the same hardware for optimal performance and optimal fail-over :

    file { '/var/www': ensure => directory }
    glusterfs::mount { '/var/www':
      fstype => 'glusterfs',
      device => $::hostname ? {
        'client1' => '192.168.0.1:/gv0',
        'client2' => '192.168.0.2:/gv0',
      }
    }

