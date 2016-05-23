class profile::tomcatrpt
{

exec { "downloadtomcat":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/tomcat8.tar.gz',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/usr/local/',
    
   }

exec { "extracttomcat":
   command => 'su -c "tar -zxvf tomcat8.tar.gz -C /usr/local/"',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/usr/local/',
    require => Exec["downloadtomcat"],
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