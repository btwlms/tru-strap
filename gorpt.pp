class profile::gorpt
{

exec { "downloadgo":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/go-agent-15.2.0-2248.noarch.rpm',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd  =>  "/usr/",
    
  }->


exec { "go_install":
   command => 'rpm -ivh go-agent-15.2.0-2248.noarch.rpm',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd  =>  "/usr/",
    require => Exec["downloadgo"],
   }

exec { "chowngo":
command   => "/bin/chown -R go:go /var/lib/go-agent/",
path       => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }

exec { "chowngoforusershare":
command  => "/bin/chown -R go:go /usr/share/go-agent/",
path      => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  }


exec { "deleting go-agent_service":
command => "rm -rf /etc/default/go-agent", 

path  => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
user => root,
}->


file {'create go-agent new file':
     ensure => present,
     path => '/etc/default/go-agent',
     content => 'GO_SERVER=10.21.1.148
export GO_SERVER
GO_SERVER_PORT=8153
export GO_SERVER_PORT
AGENT_WORK_DIR=/var/lib/${SERVICE_NAME:-go-agent}
export AGENT_WORK_DIR
DAEMON=Y
VNC=N
export JAVA_HOME=/usr/lib/jvm/java-1.8.0',
mode => 0755,
  }->


exec { "restartgo-agent_service":
command => "/etc/init.d/go-agent restart", 
path  => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
user => root,
}


}

