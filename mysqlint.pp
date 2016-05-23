class profile::mysqlint
{

if $::init_env == "e2e1"{
          exec { 'installmysql':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/e2e1/intdb/downloadintdb.sh",
		  }

		  exec { 'dbschemas':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/e2e1/intdb/intdbschema.sh",
			timeout => 100,
		  }		  
}
if $::init_env == "stub1"{
          exec { 'installmysql':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/intdb/downloadintdb.sh",
		  }

		  exec { 'dbschemas':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub1/intdb/intdbschema.sh",
		  timeout => 100,
}		  
}
if $::init_env == "stub2"{
          exec { 'installmysql':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/intdb/downloadintdb.sh",
		  }

		  exec { 'dbschemas':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/stub2/intdb/intdbschema.sh",
		  timeout => 100,
}		  
}
if $::init_env == "c1-sit1"{
          exec { 'installmysql':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/intdb/downloadintdb.sh",
		  }

		  exec { 'dbschemas':
          path    => '/usr/bin:/usr/sbin:/bin:/sbin',
          command => "sh /etc/puppet/modules/profile/files/environment/c1-sit1/intdb/intdbschema.sh",
		  timeout => 100,
}	
}

file_line { 'Adding_mysql_user':
  path  => '/etc/sudoers',
  line  => 'tomcat ALL = NOPASSWD: ALL',
}

file_line { 'commenting_mysql_user':
  path  => '/etc/sudoers',
  line  => 'Defaults:tomcat !requiretty',
}

file_line { 'commenting_mysql_user':
  path  => '/etc/sudoers',
  line  => 'Defaults:go !requiretty',
}

exec { "Addusermysql":
command   => "usermod -G root mysql",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }


}
