class profile::sensu_client
{
include ::sensu_client
 
$role_script_check = generate("/bin/sh", "-c", "/bin/ls /etc/puppet/modules/profile/templates/sensu_client/${::init_role}/check-smoketest.sh.erb | wc -l")

  
if $role_script_check == "1" {
    
file { "/opt/smoketest":
      
ensure => directory,
    
}

    
file { "/opt/smoketest/check-smoketest.sh":

ensure  => present,

content => template("profile/sensu_client/${::init_role}/check-smoketest.sh.erb"),
 
require => File[ "/opt/smoketest" ]
    
}

}

}
