#!/bin/bash
class profile::mule
{
user { 'mwgw':
  ensure     => present,
  shell      => '/bin/bash',
  home       => '/opt/application'
}

file { '/opt/application':
    ensure => 'directory',
  }


exec { "downloadmule":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/mule-enterprise-standalone-3.4.2.tar',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/',
    require => File['/opt/application'],
   }

exec { "extract":
   command => 'tar -xvf mule-enterprise-standalone-3.4.2.tar',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/',
    require => Exec["downloadmule"],
   }

exec { "downloadmuleconf":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/mule-conf.tar',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/',
    require => File['/opt/application'],
   }

exec { "extractconf":
   command => 'tar -xvf mule-conf.tar',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/',
    require => Exec["downloadmule"],
   }


exec { "downloadmulelib":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/mule-lib.tar',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/',
    require => File['/opt/application'],
   }

exec { "extractlib":
   command => 'tar -xvf mule-lib.tar',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/',
    require => Exec["downloadmule"],
   }

exec { "downloadmulecert":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/muleLicenseKey.lic',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/conf/',
    require => File['/opt/application'],
   }

exec { "Muleservice":
   command => 'sh mule start',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/bin/',
    require => Exec["extract"],
}->
exec { "Remove":
   command => 'rm -rf mule-enterprise-standalone-3.4.2.tar.gz',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/',
   }->


file { '/opt/application/mule-enterprise-standalone-3.4.2/Backup':
    ensure => 'directory',
  }

  file { '/opt/application/mule-enterprise-standalone-3.4.2/logs':
    ensure => 'directory',
  }
  
file { "/etc/sudoers.d/mwgw":
ensure  => file,
mode    => 0440,
content => "Defaults:mwgw !requiretty\nDefaults:mwgw secure_path = /usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin\nmwgw ALL = NOPASSWD: ALL",
  }

file_line { 'Adding_mwgw_user':
  path  => '/etc/sudoers',
  line  => 'Defaults:mwgw !requiretty\nDefaults:mwgw secure_path = /usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin\nmwgw ALL = NOPASSWD: ALL',
}


}
