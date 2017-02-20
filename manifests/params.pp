class htcacheclean::params {
    # OS independant params
    $config_file = '/etc/sysconfig/htcacheclean'
    $clean_interval = 15
    $clean_limit = '1024M'
    $additional_options = ''
    $clean_service = 'htcacheclean'
    $config_template = 'htcacheclean/htcacheclean.erb'
    $apache_service = 'httpd'
    $systemd_apache_required_dir = '/etc/systemd/system/httpd.service.requires'
    $systemd_apache_required_file = '/etc/systemd/system/httpd.service.requires/htcacheclean.service'
    $systemd_htcacheclean_service_file = '/usr/lib/systemd/system/htcacheclean.service'
}