class profile::intappmysql
{

exec {"download_mysqlint.sh":
        command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/mysql5.6.28/mysqlint.sh',
         path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
         cwd    => "/etc/puppet/modules/profile/files/",
}

exec {"Install_mysqlint.sh":
        command => '/bin/sh -x mysqlint.sh',
         path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
         cwd    => "/etc/puppet/modules/profile/files/",
}



}