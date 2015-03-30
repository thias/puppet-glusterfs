class glusterfs::ppa {

  include apt

  apt::ppa { 'ppa:gluster/glusterfs-3.6': 
  }

}


