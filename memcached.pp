class profile::memcached
  
{
include ::memcached

if $::init_env == "stub1"{
          exec { 'copymemcahtunnel':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/memcache/memcache.sh",
   }        
  }
if $::init_env == "stub2"{
          exec { 'copymemcahtunnel':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/memcache/memcache.sh",
   }        
 
 }

  if $::init_env == "e2e1"{
          exec { 'copymemcahtunnel':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/e2e1/memcache/memcache.sh",
   }        
  }
if $::init_env == "c1-sit1"{
          exec { 'copymemcahtunnel':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/memcache/memcache.sh",
   }        
  }
}
