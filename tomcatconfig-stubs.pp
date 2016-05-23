class profile::tomcatconfig-stubs
{

  
if $::init_env == "stub1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/actcomp/actcomp.sh",
    
}   
}
if $::init_env == "stub2"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/stubs/stubs.sh",
    
}   
}

file {"creating_file_stusb":
ensure => file,
path => '/usr/local/tomcat6/logs/tomcat-error.log',
mode => 0755,

}

}