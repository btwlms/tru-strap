class profile::stubs
{

exec { "download_corvus":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/tomcat-stubs.tar',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => "/usr/local/",
  }

exec { "corvus_extract":
   command => 'tar -xvf tomcat-stubs.tar',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => "/usr/local/",
    require => Exec["download_corvus"],
   }


if $::init_env == "e2e1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/e2e1/corvus/corvus.sh",
    
   }   
 }     
if $::init_env == "stub1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/corvus/corvus.sh",
    
}   
}
if $::init_env == "stub2"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/stubs/stubs.sh",
    
}   
}


}
