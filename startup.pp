class profile::startup {


file { '/data1':
ensure => directory,
}->

exec { "creatingfs":
    command => 'sh mount.sh',
    path => "/sbin:/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd => "/etc/puppet/modules/profile/files/",
    require => Class['::profile::reboot'],
    
}->


file_line {'/etc/fstab':
  ensure  => present,
  path    => '/etc/fstab',
  line    => '/dev/sdb1      /data1     ext4     defaults     0 0',

 
}
}