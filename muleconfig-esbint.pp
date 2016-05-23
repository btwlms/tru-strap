class profile::muleconfig-esbint
{

  if $::init_env == "e2e1"{
          exec { 'copymuleconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/e2e1/esbint/esbint.sh",
   }        
  
  }
  if $::init_env == "stub1"{
          exec { 'copymuleconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/esbint/esbint.sh",
   }        
  }
if $::init_env == "stub2"{
          exec { 'copymuleconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/esbint/esbint.sh",
   }        
  }
if $::init_env == "c1-sit1"{
          exec { 'copymuleconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/esbint/esbint.sh",
   }        
  }
}