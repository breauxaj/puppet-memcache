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
