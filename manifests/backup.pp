# == Class: system::backup
#
# Ensures preconditions for having clean backups.
#
# === Examples
#
#  class { 'system::backup': }
#
# === Authors
#
# Christian Haeusler <christian.haeusler@md-systems.ch>
#
# === Copyright
#
# Copyright 2013 MD Systems.
#
class system::backup {
  if defined(Class['mysql::server']) {
    include mysql::backup
  }
}
