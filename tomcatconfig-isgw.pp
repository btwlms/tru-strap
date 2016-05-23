class profile::tomcatconfig-isgw
{

if $::init_env == "e2e1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/e2e1/isgw/isgw.sh",
}        
  
}
if $::init_env == "stub1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/isgw/isgw.sh",
}        
  
}
if $::init_env == "stub2"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/isgw/isgw.sh",
}        
  
}
if $::init_env == "c1-sit1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/isgw/isgw.sh",
}        
  
}

file {"creating_file_stusb":
ensure => file,
path => '/usr/local/tomcat6/logs/tomcat-error.log',
mode => 0755,

}

}

