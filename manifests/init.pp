# == Class: glusterfs
#
# Sets up basic packaging for Debian
#
# === Parameters
#
# [*major*]
#   major version for glusterfs
# [*minor*]
#   minor version for glusterfs
# [*release*]
#   release number
# [*gpg_key_id*]
#   optional GPG key ID
#
# === Examples
#
# class { 'glusterfs':
#  $major    => '3',
#  $minor    => '7',
#  $release  => '6',
# }
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2016 Braiins Systems s.r.o.
#
class glusterfs (
  $major,
  $minor,
  $release,
  $gpg_key_id='A4703C37D3F4DE7F1819E980FE79BB52D5DC52DC',
) {

  $maj_min = "${major}.${minor}"
  $url_base = "https://download.gluster.org/pub/gluster/glusterfs/${maj_min}/${maj_min}.${release}"
  apt::key { $gpg_key_id:
    key_source => "${url_base}/pub.key"
  } ->
  apt::source { 'gluster':
    location    => "${url_base}/Debian/${lsbdistcodename}/apt",
    release     => $lsbdistcodename,
    repos       => 'main',
    include_src => false,
  }
  apt::pin { 'gluster':
    priority => '700',
    packages => 'gluster*',
    codename  => $lsbdistcodename,
  }
}
