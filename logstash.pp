class profile::logstash
{
file { '/etc/yum.repos.d/logstash.repo':
ensure => file,
content => '
[logstash-2.2]
name=Logstash repository for 2.2.x packages
baseurl=http://packages.elastic.co/logstash/2.2/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1',
}->

exec { "installing_logstash":
command => 'yum -y install logstash',
path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",

}->


file { '/etc/logstash/conf.d/logstash.conf':
          ensure  => present,
          content => template("profile/go-agent/${::init_role}/logstash.conf.erb"),

}->


exec { "giving_permissions":
        command => 'chmod 755 -R /var/log/logstash/',
        path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
        require => Exec["installing_logstash"],

}->

file_line { "Update_logstash":
line => 'PATH=/sbin:/usr/sbin:/bin:/usr/bin:$JAVA_HOME
export JAVA_HOME=/usr/lib/jdk1.8.0_72',
path => "/etc/init.d/logstash",
match => 'PATH=/sbin:/usr/sbin:/bin:/usr/bin',
}->

exec { 'check_logstash_service':
command => '/etc/init.d/logstash start',
path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
}->

exec { "checking_config":
command => 'chkconfig logstash on',
path => "/usr/bin:/sbin:/bin:/usr/local/bin",
}


}
