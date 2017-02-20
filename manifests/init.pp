class htcacheclean  (
    $cache_directory,
    $config_file                       = $htcacheclean::params::config_file,
    $config_template                   = $htcacheclean::params::config_template,
    $clean_interval                    = $htcacheclean::params::clean_interval,
    $clean_limit                       = $htcacheclean::params::clean_limit,
    $clean_service                     = $htcacheclean::params::clean_service,
    $apache_service                    = $htcacheclean::params::apache_service,
    $additional_options                = $htcacheclean::params::additional_options,
    $systemd_apache_required_dir       = $htcacheclean::params::systemd_apache_required_dir,
    $systemd_apache_required_file      = $htcacheclean::params::systemd_apache_required_file,
    $systemd_htcacheclean_service_file = $htcacheclean::params::systemd_htcacheclean_service_file,
    ) inherits htcacheclean::params {

    case $::osfamily {
        'Debian': {
            notice('htcacheclean - This module only runs on RedHat based systems')
        }
        'RedHat': {
            if ($::operatingsystemmajrelease == '7') {
                # deploy config file
                file {$systemd_apache_required_dir:
                    ensure => 'directory',
                    path   => $systemd_apache_required_dir,
                    owner  => 'root',
                    group  => 'root',
                    mode   => '0755'
                } ->
                file {$systemd_apache_required_file:
                    ensure => 'link',
                    target => $systemd_htcacheclean_service_file
                } ->
                file {$config_file:
                    ensure  => 'file',
                    content => template($config_template),
                    path    => $config_file,
                    owner   => 'root',
                    group   => 'root',
                    mode    => '0755',
                    notify  => Exec['restart_apache']
                } ->
                service {$clean_service:
                    ensure => 'running'
                }

                # restart the apache service is notified to do so
                exec { 'restart_apache':
                    command     => "service ${apache_service} restart",
                    refreshonly => 'true'
                }
            }
            else {
                fail("htcacheclean - Unsupported RHEL/CentOS Version: ${::operatingsystemmajrelease}")
            }
        }
        default: {
            fail("htcacheclean - Unsupported Operating System Family: ${::osfamily}")
        }
    }
}
