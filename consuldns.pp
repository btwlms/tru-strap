class profile::consuldns($dnsserver="",$searchdomain="",$envtype=$::init_env) { 


  
exec { "download_consul.gz":
        command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/consul-dns/consul.gz',
        path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd => "/usr/local/bin/",
}
exec {"extract_consul.gz":
        command => 'gunzip consul.gz',
         path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd => "/usr/local/bin/",
        require => Exec["download_consul.gz"],
                }

exec {"permission_consul.gz":
        command => '/bin/chmod 755 consul',
         path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd => "/usr/local/bin/",
        require => Exec["extract_consul.gz"],
                }->

exec {"make_client_dir":
        command => 'mkdir -p /etc/consul.d/client',
        path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
}

exec {"make_consul_dir":
        command => 'mkdir /var/consul',
        path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
}

exec {"copy_consul":
        command => 'cp consul /etc/init.d/consul',
         path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd => "/etc/puppet/modules/profile/files",
}->

exec {"permission_consul":
         command => '/bin/chmod 755 /etc/init.d/consul',
         path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
         require => Exec["copy_consul"],
}->

file { '/etc/consul.d/client/config.json':
          ensure  => present,
          content => template("profile/go-agent/config.json.erb"),
          require => Exec["make_client_dir"],
}->

exec { "removing_etc_resolv":
        command => 'rm -rf /etc/resolv.conf',
        path => "/usr/bin:/sbin:/bin:/usr/local/bin",
}

if ($init_env == "e2e1"){
         
file { 'creating_newfile':
    ensure => file,
    path => "/etc/resolv.conf",
    content => 'search btwlms.internal
nameserver 127.0.0.1
nameserver 10.21.102.1',
require => Exec["removing_etc_resolv"],
  } 
}

if ($init_env == "stub1"){
         
file { 'creating_newfile':
    ensure => file,
    path => "/etc/resolv.conf",
    content => 'search btwlms.internal
nameserver 127.0.0.1
nameserver 10.21.101.1',
require => Exec["removing_etc_resolv"],

  } 
}


if ($init_env == "stub2"){
         
file { 'creating_newfile':
    ensure => file,
    path => "/etc/resolv.conf",
    content => 'search btwlms.internal
nameserver 127.0.0.1
nameserver 10.21.104.1',
require => Exec["removing_etc_resolv"],

  } 
}

if ($init_env == "c1-sit1"){
         
file { 'creating_newfile':
    ensure => file,
    path => "/etc/resolv.conf",
    content => 'search btwlms.internal
nameserver 127.0.0.1
nameserver 10.21.103.1',
require => Exec["removing_etc_resolv"],

  } 
}


exec { "checking_config_consul":
        command => 'chkconfig consul on',
        path => "/usr/bin:/sbin:/bin:/usr/local/bin",
}->

exec {"chattr_resolv.conf":
        command => 'chattr +i /etc/resolv.conf',
        path =>  "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        require => File['creating_newfile'],
}

exec {"start_consul_service":
        command => '/etc/init.d/consul start',
        path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        user => root,
        require => Exec["permission_consul"],
}


}
