# Class: memcache
#
# This class installs the memcached package
#
# Parameters:
#
#  ensure: (default latest)
#    Determine the state of the packages
#
# Actions:
#   - Installs the memcached package
#
# Requires:
#
# Sample Usage:
#
#  For a standard installation, use:
#
#    class { 'memcache':
#      ensure => 'latest'
#    }
#
#  To remove the installation, use:
#
#    class { 'memcache':
#      ensure => 'absent'
#    }
#
class memcache (
  $ensure = 'latest'
){
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'memcached',
  }

  $paths = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/run/memcached',
  }

  package { $required: ensure => $ensure }

  file { $paths:
    ensure => directory,
    owner  => 'memcached',
    group  => 'memcached',
    mode   => '0755',
  }

  group { 'memcached':
    ensure => present,
    gid    => 70,
  }

  user { 'memcached':
    ensure     => present,
    gid        => 70,
    home       => '/var/lib/memcached',
    shell      => '/sbin/nologin',
    managehome => true,
    uid        => 70,
  }

}
