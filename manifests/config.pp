define memcache::config (
  $port = 11211,
  $maxconnection = 1024,
  $cachesize = 64,
  $options = ''
) {
  $service = $::operatingsystem ? {
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
