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
	
exec { "renameconf":
        command => 'mv conf conf-old',
         path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd  => '/opt/application/mule-enterprise-standalone-3.4.2',
         require => Exec["extractmule"],
   }

exec { "downloadmuleconf":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/mule-conf.tar',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/',
	require => Exec["extractmule"],
   }
   
exec { "extractconf":
   command => 'tar -xvf mule-conf.tar',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/',
   require => Exec["downloadmuleconf"],
   }
 
exec { "renamelickey":
        command => 'mv muleLicenseKey.lic muleLicenseKey.lic-old',
         path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd  => '/opt/application/mule-enterprise-standalone-3.4.2/conf/',
         require => Exec["extractconf"],
   }
   
exec { "downloadmulecert":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/muleLicenseKey.lic',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/conf/',
    require => Exec["extractconf"],
   }

exec { "downloadmulelib":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/mule-lib.tar',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/',
 require => Exec["extractmule"],
}

exec { "extractlib":
      command => 'tar -xvf mule-lib.tar',
      path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
      cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/',
      require => Exec["downloadmulelib"],
   }

	
exec { "makelogsdir":
        command => 'mkdir logs',
        path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd => '/opt/application/mule-enterprise-standalone-3.4.2/',
        require => Exec["extractmule"],

}

exec { "makeBackupdir":
        command => 'mkdir Backup',
        path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd => '/opt/application/mule-enterprise-standalone-3.4.2/',
        require => Exec["extractmule"],
}

exec { "chmodmwgw":
command   => "/bin/chmod -R 755 /opt/application/mule-enterprise-standalone-3.4.2/",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',

}->

exec { "chownmwgw":
command   => "/bin/chown -R mwgw:mwgw /opt/application/mule-enterprise-standalone-3.4.2/",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',

}


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

exec { "Removeartifactsfromwar":
    command => 'rm -rf *',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/mule-enterprise-standalone-3.4.2/apps/',
    require => Exec["extractmule"],
}

}

