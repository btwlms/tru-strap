class profile::basedb {
  include ::profile::sensu_client
  augeas { "disable-crond-emails":
    context => "/files/etc/sysconfig/crond",
    changes => 'set CRONDARGS \'"-m off"\'',
    notify  => Service["crond"],
  }
  service { 'crond': }

  package { 'bash': ensure => latest }
  
  exec { "Iptablesoff":
    command => '/etc/init.d/iptables stop',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    
   }

file { "/etc/sudoers.d/go":
ensure  => file,
mode    => 0440,
content => "go ALL = NOPASSWD: ALL",
  }

file_line { 'Adding_go_user':
  path  => '/etc/sudoers',
  line  => 'go ALL=(ALL) NOPASSWD: ALL',
  
}


file_line { "mountafter_2minutes":
  line => 'sh /etc/puppet/modules/profile/files/dbmount.sh',
  path => "/etc/rc.local",
   
 }

exec { "download_logrotate.conf":
  command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/logrotate.conf',
  path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
  cwd => "/etc/puppet/modules/profile/files",

}
exec {"replace_logrotate.conf":
   command => 'rsync logrotate.conf /etc/logrotate.conf',
   path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
   cwd => "/etc/puppet/modules/profile/files",
   require => Exec["download_logrotate.conf"],
}

file_line { 'setting_javahome':
path  => '/etc/profile',
line  => 'export JAVA_HOME=/usr/java/jdk1.6.0_37/',
}
exec { "etchosts":
command   => '/bin/echo "127.0.0.1 $HOSTNAME" >> /etc/hosts',
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }

exec { "etcsysconfig":
command   => '/bin/echo "HOSTNAME=$HOSTNAME" >> /etc/sysconfig/network',
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }

}
