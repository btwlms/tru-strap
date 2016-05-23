#!/bin/bash
class profile::intapp
{
user { 'intalio':
  ensure     => present,
  shell      => '/bin/bash',
  home       => '/opt/application'
}
file { '/opt/application':
    ensure => 'directory',
  }->

file { '/opt/application/intalio-bpms-ee-6.2.12-tomcat-5-5.5.33/':
    ensure => 'directory',
    require => File['/opt/application'],
  }

exec { "downloadinttar":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/intalio.tar',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/intalio-bpms-ee-6.2.12-tomcat-5-5.5.33/',
    }

exec { "extract":
   command => 'tar -xvf intalio.tar',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/intalio-bpms-ee-6.2.12-tomcat-5-5.5.33/',
    require => Exec["downloadinttar"],
}


file_line { 'setting_path':
  path  => '/etc/profile',
  line  => 'export PATH=$PATH:/usr/java/jdk1.6.0_37/bin/',
}->

exec {"setjavapath":
   command => 'source /etc/profile',
   path => "/etc/profile",
   provider => "shell",
}->


exec { "makeBackupdirinvar":
        command => 'mkdir Backup',
        path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd => '/opt/application/intalio-bpms-ee-6.2.12-tomcat-5-5.5.33/var/',
        require => Exec["extract"],
}->


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
exec { 'check_intapp_service':
command => '/bin/sh startup.sh',
path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
cwd => "/opt/application/intalio-bpms-ee-6.2.12-tomcat-5-5.5.33/bin"
}

}