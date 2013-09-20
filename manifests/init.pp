class memcache {
  $required = $::operatingsystem ? {
    /(?i-mx:centos|fedora|redhat|scientific)/ => 'memcached',
  }

  $paths = $::operatingsystem ? {
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
