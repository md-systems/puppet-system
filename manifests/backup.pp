# == Class: system::facts
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
  if defined( "::mysql::backup") {
    class {'mysql::backup':
      defaults           => '/etc/mysql/debian.cnf',
      backupdir          => '/var/backups/mysql',
      backuprotate       => 2,
      delete_before_dump => true,
    }
  }
}
