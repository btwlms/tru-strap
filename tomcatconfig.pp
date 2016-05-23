class profile::tomcatconfig
{

exec { "chmodtomcat":
command   => "/bin/chmod +x /opt/wlms-provisioning/puppet/modules/profile/files/",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
}

exec { "chowntomcat":
command   => "/bin/chown -R go:root /opt/wlms-provisioning/puppet/modules/profile/files/",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
}

file { '/deploy':
    ensure => 'directory',
  }->


file { '/deploy/Backup':
    ensure => 'directory',
  }->

exec { "artifactdeploydirectory":
command   => "/bin/chmod -R 755 /deploy",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
}->

exec { "artifactdeploydirectorypermission":
command   => "/bin/chown -R go:root /deploy/",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
}
}