class memcache {
  $required = $operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'memcached',
  }

  $paths = $operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => '/var/run/memcached',
  }

  package { $required: ensure => latest }
    
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

class memcache::service ( $ensure,
                          $enable ) {
  $service = $operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'memcached',
  }

  service { $service:
    ensure    => $ensure,
    enable    => $enable,
  }
}

define memcache::config ( $port = 11211,
                          $maxconnection = 1024,
                          $cachesize = 64,
                          $options = '' ) {
  $service = $operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'memcached',
  }

  file { '/etc/sysconfig/memcached':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('memcache/sysconfig.erb'),
    notify  => Service[$service],
  }

}
