class profile::activemq
{
user { 'actmq':
  ensure     => present,
  shell      => '/bin/bash',
  home       => '/opt/application'
}

file { '/opt/application':
    ensure => 'directory',
        }

exec { "downloadactivemq":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/stub2/activemq/apache-activemq-5.5.1.tar',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/',
    require => File['/opt/application'],
   }

exec { "extractactivemq":
   command => 'tar -xvf apache-activemq-5.5.1.tar',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => '/opt/application/',
    require => Exec["downloadactivemq"],
   }->


 file_line { 'service_activemq_service':
  path  => '/etc/profile',
  line  => 'export JAVA_HOME=/usr/java/jdk1.6.0_37',
}


file_line { "restartservice_2minutes":
  line => '/opt/application/apache-activemq-5.5.1/bin/activemq start',
  path => "/etc/rc.local",

 }

 }
