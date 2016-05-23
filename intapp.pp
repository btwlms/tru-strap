class profile::intapp
{
user { 'intalio':
  ensure     => present,
  shell      => '/bin/bash',
  home       => '/opt/application'
}


if $::init_env == "e2e1"{
          exec { 'copyintappconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/e2e1/intapp/intapp.sh",
    
   }   
 }     
if $::init_env == "stub1"{
          exec { 'copyintappconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/intapp/intapp.sh",
    
   }   
 }
  if $::init_env == "stub2"{
          exec { 'copyintappconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/intapp/intapp.sh",
    
   }   
 }
if $::init_env == "c1-sit1"{
          exec { 'copyintappconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/intapp/intapp.sh",
    
   }   
 }
file_line { 'Adding_intalio_user':
  path  => '/etc/sudoers',
  line  => 'Defaults:intalio !requiretty',
}->

file_line { 'commenting_gointapp_user':
  path  => '/etc/sudoers',
  line  => 'Defaults:go !requiretty',
}

file_line { 'Adding_intapp_user_permissions':
  path  => '/etc/sudoers',
  line  => 'intalio ALL = NOPASSWD: ALL',
 }

file_line { 'service_intapp_service':
  path  => '/etc/profile',
  line  => 'export JAVA_HOME=/usr/java/jdk1.6.0_37',
}


file_line { "restartservice_2minutes":
  line => 'sh /opt/application/intalio-bpms-ee-6.2.12-tomcat-5-5.5.33/bin/startup.sh',
  path => "/etc/rc.local",
   
 }
 

}