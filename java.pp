class profile::java
{

exec { "downloadjavaforgo":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/jdk-8u72-linux-x64.tar.gz',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd  =>  "/usr/lib/",
 }

 exec { "extractjavaforgo":
    command => 'tar -xvf jdk-8u72-linux-x64.tar.gz',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd  =>  "/usr/lib/",
    require => Exec["downloadjavaforgo"],
 }

exec { "downloadjava":
    command => 'wget https://s3-eu-west-1.amazonaws.com/bt-wlms-file-repo/jdk-6u37-linux-amd64.rpm',
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd  =>  "/usr/",
    
  }->


exec { "java_install":
   command => 'rpm -ivh jdk-6u37-linux-amd64.rpm',
    path   => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    cwd  =>  "/usr/",
    require => Exec["downloadjava"],
   }


}

