class profile::tomcatconfig-rpt
{

if $::init_env == "e2e1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/e2e1/rpt/rpt.sh",
    
   }   
 }     

if $::init_env == "stub1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/rpt/rpt.sh",
    
  } 
 }  
if $::init_env == "stub2"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/rpt/rpt.sh",
    
  } 
 } 
if $::init_env == "c1-sit1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/rpt/rpt.sh",
    
  } 
 } 

}
