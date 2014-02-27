# == Class: system::ssh
#
# Manage ssh service and exchange host keys on all nodes.
#
# === Examples
#
#  class { 'system::ssh': }
#
# === Authors
#
# Christian Haeusler <christian.haeusler@md-systems.ch>
#
# === Copyright
#
# Copyright 2013 MD Systems.
#
class system::ssh (
  $hostname = $::hostname,
  $sshdsakey = $::sshdsakey
) {
  package {'ssh':
    ensure => present,
  }

  file {'/etc/ssh/sshd_config':
    ensure  => present,
    content => template('system/sshd_config.erb'),
    require => Package['ssh'],
    notify  => Service['ssh'],
  }

  service {'ssh':
    ensure  => running,
    require => Package['ssh'],
  }

  @@sshkey { $hostname: type => dsa, key => $sshdsakey }
  Sshkey <<| |>> {
    require => Service['ssh'],
  }
}
