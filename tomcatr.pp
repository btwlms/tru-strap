class profile::tomcatr
{

exec { "downloadtomcat":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/tomcat8.tar.gz',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/usr/local/',

   }

exec { "extracttomcat":
   command => 'tar -xvf tomcat8.tar.gz',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/usr/local/',
    require => Exec["downloadtomcat"],

}

 exec { "permissiontomcat":
           command => 'chmod 755 *',
            path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
            cwd    => '/usr/local/tomcat8/',
            require => Exec["extracttomcat"],

}

exec { "userpermissiontomcat":
   command => '/bin/chown -R tomcat:tomcat tomcat8',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/usr/local/',
    require => Exec["extracttomcat"],
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

if $::init_env == "c1-sit1"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/rpt/rpt.sh",
    
  } 
 } 

if $::init_env == "stub2"{
          exec { 'copytomcatconfig':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/rpt/rpt.sh",
    
  } 
 } 

}