class profile::reboot
{

file_line {'/etc/fstab':
  ensure  => present,
  path    => '/etc/fstab',
  line    => '/dev/sdb1      /data1     ext4     defaults     0 0',
}

file_line {'crontab_entry':
  ensure  => present,
  path    => '/var/spool/cron/root',
  line    => '*/5 * * * * sh /etc/puppet/modules/profile/files/mount.sh'
  
}
exec { "chmodtoexecutablefiles":
command   => "/bin/chmod 755 -R /etc/puppet/modules/profile/files/",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }

reboot { 'now':
  subscribe => Exec["chmodtoexecutablefiles"]
}

}

