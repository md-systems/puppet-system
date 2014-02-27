# == Class: system::packages
#
# Mass management of simple packages that does not need service and config file
# management.
#
# === Parameters
#
# Document parameters here.
#
# [*packages*]
#   A hash of package definitions.
#
# === Examples
#
#  class { 'system::packages':
#    packages => { vim => { ensure => present } }
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
class system::packages (
  $packages = {}
) {
  $pakages_all_hierarchies = hiera_hash('system::packages::packages',$packages)
  create_resources('package', $pakages_all_hierarchies)
}
