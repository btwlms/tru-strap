class profile::maven {


file { '/etc/profile.d/':
    ensure => 'directory',
  }


exec { "download maven":
    command => 'wget http://mirrors.gigenet.com/apache/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => "/opt/",
  }

exec { "maven_extract":
   command => 'su -c "tar -zxvf apache-maven-3.0.5-bin.tar.gz -C /opt/"',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd    => "/opt/",
   }

file { "maven.sh":
content => 'export M2_HOME=/opt/apache-maven-3.0.5
export M2=$M2_HOME/bin 
PATH=$M2:$PATH',
path => '/etc/profile.d/maven.sh',
owner => root,
mode => 755,
require => File['/etc/profile.d'],


}
}