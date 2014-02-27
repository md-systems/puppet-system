# == Class: system::facts
#
# Manages a list of static node facts. The class takes the given fact and writes
# it to facts yaml file.
# This allows to use FACTER_<factname>=<value> puppet agent -t to initially set
# or to change a fact.
#
# List of supported facts:
#
# - role: Role of the node.
# - location: Location string of the node.
#
# === Examples
#
#  class { 'system::facts': }
#
# === Authors
#
# Christian Haeusler <christian.haeusler@md-systems.ch>
#
# === Copyright
#
# Copyright 2013 MD Systems.
#
class system::facts {

  $facts_dirs = ['/etc/facter', '/etc/facter/facts.d']

  file { $facts_dirs:
    ensure => 'directory',
  }

  file { '/etc/facter/facts.d/static.yaml':
    ensure  => present,
    content => template('system/static_facts.yaml.erb'),
    require => File[$facts_dirs]
  }
}
