# Define: memcache::service
#
# This define manages the memcached service
#
# Parameters:
#
#  ensure:
#    Controls the state of the service
#
#  enable:
#    Controls the service start on boot
#
# Actions:
#   - Stops/starts the memcached service
#
# Requires:
#
# Sample Usage:
#
#  To enable the service, use:
#
#    memcache::service { 'default':
#      ensure => running,
#      enable => true
#    }
#
define memcache::service (
  $ensure,
  $enable
) {
  $service = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'memcached',
  }

  service { $service:
    ensure => $ensure,
    enable => $enable,
  }

}
