class profile::tomcat
{

exec { "downloadtomcat":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/tomcat6.tar.gz',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/usr/local/',

   }

exec { "extracttomcat":
   command => 'tar -xvf tomcat6.tar.gz',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/usr/local/',
    require => Exec["downloadtomcat"],
   }

exec { "chowngodeploy":
command   => "/bin/chown -R go:root /opt/wlms-provisioning/puppet/modules/profile/files/",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }


exec { "chmodtomcat":
command   => "/bin/chmod -R 755 /usr/local/tomcat6/*",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
require => Exec["extracttomcat"],
}

exec { "chowntomcat":
command   => "/bin/chown -R tomcat:tomcat /usr/local/tomcat6/*",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
require => Exec["chmodtomcat"],
}

file_line { 'Adding_tomcat_user':
  path  => '/etc/sudoers',
  line  => 'tomcat ALL = NOPASSWD: ALL',
}

file_line { 'commenting_tomcat_user':
  path  => '/etc/sudoers',
  line  => 'Defaults:tomcat !requiretty',
}

file_line { 'commenting_root_user':
  path  => '/etc/sudoers',
  line  => 'Defaults:go !requiretty',
}

exec { "Addusergo":
command   => "usermod -G root go",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }

exec { "Addgrouptomcat":
command   => "groupadd tomcat",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }


exec { "Addusertomcat":
command   => "useradd -g tomcat tomcat",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }


}

