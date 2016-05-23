class profile::muleconfig-esbext
{

  if $::init_env == "e2e1"{
          exec { 'copymuleconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/e2e1/esbext/esbext.sh",
   }        
  
  }
  if $::init_env == "stub1"{
          exec { 'copymuleconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/esbext/esbext.sh",
   }        
  }
 if $::init_env == "stub2"{
          exec { 'copymuleconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/esbext/esbext.sh",
   }        
  }
if $::init_env == "c1-sit1"{
          exec { 'copymuleconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/esbext/esbext.sh",
   }        
  }
}