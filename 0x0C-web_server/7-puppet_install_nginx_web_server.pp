# Script to install nginx using puppet

package {'nginx':
  ensure => present,
}

exec {'install':
  command  => 'sudo apt-get update ; sudo apt-get -y install nginx',
  provider => shell,

}

# Create HTML file with Hello World!
file { '/var/www/html/index.html':
  ensure  => present,
  content => "<html><body>Hello World!</body></html>",
}

# Restart Nginx service
service { 'nginx':
  ensure => running,
  enable => true,
  require => [Package['nginx'], File['/etc/nginx/sites-available/default'], File['/var/www/html/index.html']],
}
