# == Class: system::motd
#
# Manages the banner message shown on login to display information about the
# node.
#
# The information shown is built in the template using global available facts.
#
# === Examples
#
#  class { 'system::motd': }
#
# === Authors
#
# Christian Haeusler <christian.haeusler@md-systems.ch>
#
# === Copyright
#
# Copyright 2013 MD Systems.
#
class system::motd {
  file {'/etc/motd':
    ensure  => present,
    content => template('system/motd.erb'),
  }
}