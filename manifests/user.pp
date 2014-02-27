# == Define: system::user
#
# Manages a single user and its associated ssh keys. The defined resources are
# defined as virtual and needs to be materialized at some other place.
#
# === Parameters
#
# Document parameters here.
#
# [*ensure*]
#   The basic state that the object should be in. Valid values are present,
#   absent.
#
# [*groups*]
#   The groups to which the user belongs. The primary group should not be
#   listed, and groups should be identified by name rather than by GID. Multiple
#   groups should be specified as an array.
#
# [*keys*]
#   A array of hashes with ssh keys this user can use to authenticate. The hash
#   must contain a name and key index.
#   - name: It is considered to use the ssh keys identifier.
#   - key: The key must be the public key hash in rsa format without the format
#     and identifier.
#
# [*comment*]
#   A description of the user. Generally the user's full name.
#   Defaults to username.
#
# [*shell*]
#   The user's login shell. The shell must exist and be executable.
#   Defaults to '/bin/bash'.
#
# === Examples
#
#  system::user { 'cha':
#    ensure => present,
#    groups => ["sysadmins", "developers"]
#    keys => [{
#      name => name@example.com,
#      key => AAAAB3Nza...YfQ==
#    }],
#    shell => '/bin/zsh'
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
define system::user (
  $ensure,
  $groups,
  $projects = [],
  $keys = undef,
  $comment = $name,
  $shell = "/bin/bash"
) {

  @user {$name:
    ensure => $ensure,
    home => "/home/${name}",
    managehome => true,
    shell => $shell,
    groups => $groups,
    password => '*',
  }

  @sudo::sudoers {$name:
    users => $name,
    runas => $projects,
    tags => ['NOPASSWD'],
    tag => prefix($projects, 'project_'),
  }

  if $keys {
    each($keys) |$key| {
      @ssh_authorized_key {$key['name']:
        ensure => $ensure,
        type => 'rsa',
        key => $key['key'],
        user => $name,
        tag => $groups
      }

      each($projects) |$project| {
        @ssh_authorized_key {"${name}_${project}_${key['name']}":
          ensure => $ensure,
          type => 'rsa',
          key => $key['key'],
          user => $project,
          tag => "project_${project}"
        }
      }
    }
  }
  else {
    file {"/home/${name}/.ssh/authorized_keys":
      ensure => absent,
    }
  }
}
