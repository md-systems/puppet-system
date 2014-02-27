# == Class: system::groups
#
# Mass management of user groups.
#
# === Parameters
#
# [*groups*]
#   A hash of group definitions.
#
# === Examples
#
#  class { 'system::groups':
#    groups => { sysadmins => { ensure => present }}
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

class system::groups (
  $groups = {}
) {
  create_resources('group', $groups)
}
