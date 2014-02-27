# == Class: system::users
#
# Manages a list of users.
#
# === Parameters
#
# [*users*]
#   A hash of user definitions. See system::user.
#
# [*root_keys*]
#   An array of hashes with ssh keys for the root user. See system::user::key.
#
# === Examples
#
#  class { 'system::users':
#    users => { 'cha' => {
#      ensure => present,
#      groups => ["sysadmins", "developers"]
#      keys => [{
#        name => name@example.com,
#        key => AAAAB3Nza...YfQ==
#      }],
#      shell => '/bin/zsh'
#    }
#    root_keys = [{
#      name => cbi1-05,
#      key => AAAAB3Nza...YfQ==
#    }]
#  }
#
# === Authors
#
# Christian Haeusler <christian.haeusler@md-systems.ch>
#
# === Copyright
#
# Copyright 2013 MD Systems.
#
class system::users (
  $users,
  $root_password,
  $root_keys = []
) {
  create_resources("system::user", hiera_hash('system::users::users', $users))

  user {'root':
    ensure => present,
    home => '/root',
    managehome => true,
    shell => '/bin/bash',
    password => $root_password,
  }

  each($root_keys) |$key| {
    ssh_authorized_key {$key['name']:
      ensure => present,
      type => 'rsa',
      key => $key['key'],
      user => 'root',
    }
  }
}
