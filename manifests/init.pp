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
  $download_host = 'download.gluster.org'
  $url_base = "https://${download_host}/pub/gluster/glusterfs/old-releases/${maj_min}/${maj_min}.${release}"
  # GFS bug: https://github.com/gluster/glusterfs-debian/issues/11
  $ensure = $lsbdistcodename ? {
    'stretch' => absent,
    default   => present,
  }

  apt::key { $gpg_key_id:
    key_source => "${url_base}/pub.key",
    ensure     => $ensure,
  } ->
  apt::source { 'gluster':
    location    => "${url_base}/Debian/${lsbdistcodename}/apt",
    release     => $lsbdistcodename,
    repos       => 'main',
    include_src => false,
    ensure      => $ensure,
  }
  apt::pin { 'gluster':
    priority => '700',
    packages => 'gluster*',
    origin   => $download_host,
    ensure   => $ensure,
  }
}
