class glusterfs::ppa(
  $ppa = 'ppa:gluster/glusterfs-3.4'
) {

  include apt

  apt::ppa { $ppa: 
  }

}


