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
exec { "extractmule":
   command => 'tar -xvf mule-enterprise-standalone-3.4.2.tar',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/',
    require => Exec["downloadmule"],
   }->
	
file_line { 'Adding_mwgw_user_in_visudo':
  path  => '/etc/sudoers',
  line  => 'mwgw ALL = NOPASSWD: ALL',
}

file_line { 'commenting_mwgw_user_in_visudo':
  path  => '/etc/sudoers',
  line  => 'Defaults:mwgw !requiretty',
}

file_line { 'commenting_root_user':
  path  => '/etc/sudoers',
  line  => 'Defaults:go !requiretty',
}

file_line { "mule_mount":
  line => 'sh /etc/puppet/modules/profile/files/muleservice.sh',
  path => "/etc/rc.local",
   
 }

}

