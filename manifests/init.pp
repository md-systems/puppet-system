# == Class: system
#
# Base system configurations common for all systems.
#
# This class includes and collects classes groups and users defined in the
# system namespace.
#
# By default the groups sysadmins and <hostname>_sysadmins and the users
# assigned to those groups are collected.
#
# === Examples
#
#  class { 'system': }
#
# === Authors
#
# Christian Haeusler <christian.haeusler@md-systems.ch>
#
# === Copyright
#
# Copyright 2013 MD Systems.
#
class system {
  include system::facts
  include system::groups
  include system::packages
  include system::ssh
  include system::users
  include system::backup

  Class['system::groups']
    -> User<| groups == 'sysadmins' |>
    -> User<| groups == "${::hostname}_sysadmins" |>
    -> Ssh_authorized_key<| tag == 'sysadmins' |>
    -> Ssh_authorized_key<| tag == "${::hostname}_sysadmins" |>

  Apt::Source<<| tag == $::location |>>
    -> Apt::Source<<| tag == $::company |>>
    -> Apt::Source<<| tag == "${::company}-${::location}" |>>
    -> Class['system::packages']

  file { '/etc/ssl/openssl.cnf':
    ensure  => present,
    content => template('system/openssl.cnf.erb'),
  }
}
