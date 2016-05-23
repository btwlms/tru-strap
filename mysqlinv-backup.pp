class profile::mysqlinv
{
exec { "download_mysql_5.1.57.sh":
        command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/mysql5.1.57/mysql-5.1.57.sh',
        path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
         cwd    => "/etc/puppet/modules/profile/files/",
}

exec { "permission_mysql-5.1.57.sh":
        command => '/bin/chmod 755 mysql-5.1.57.sh',
         path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
         cwd    => "/etc/puppet/modules/profile/files/",
        require => Exec["download_mysql_5.1.57.sh"],
}


exec {"install_mysql_5.1.57":
        command => '/bin/sh mysql-5.1.57.sh',
         path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
         cwd    => "/etc/puppet/modules/profile/files/",
        require => Exec["permission_mysql-5.1.57.sh"],
}

exec { "start_mysql_service":
        command => '/etc/init.d/mysql start',
        path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        user => root,
        require => Exec["install_mysql_5.1.57"],
}

exec {"download_all_databases":
   command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/databases.sql',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => "/etc/puppet/modules/profile/files/",
  }

exec {"permissions_database.sql":
        command  => '/bin/chmod 755 *.*',
   path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => "/etc/puppet/modules/profile/files/",
 require => Exec["download_all_databases"],
}
exec {"createdbs":
        command => '/bin/sh downloadinvdb.sh',
         path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
          cwd    => "/etc/puppet/modules/profile/files/",
        require => Exec["start_mysql_service"],
        timeout => 100,
 }

exec {"import_dbs":
        command => '/bin/sh importinvdb.sh',
         path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
          cwd    => "/etc/puppet/modules/profile/files/",
        require => Exec["createdbs"],
        timeout => 10000,
 }

exec {"Permissionstoerrorlog":
        command => '/bin/sh perminv.sh',
         path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        cwd    => "/etc/puppet/modules/profile/files/",
        
 }

}
