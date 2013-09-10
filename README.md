memcache
========

Samples
-------
```
include memcache
```
```
memcache::config { 'default':
  port          => '11211',
  maxconnection => '1024',
  cachesize     => '64',
  options       => '',
}
```
