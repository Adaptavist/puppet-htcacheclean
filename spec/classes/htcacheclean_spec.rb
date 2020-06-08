require 'spec_helper'

describe 'htcacheclean', :type => 'class' do

  fail_operatingsystemrelease = '5'
  fail_operatintsystem = 'Solaris'
  cache_directory = "/opt/apache/cache"
  config_file  = '/etc/sysconfig/htcacheclean'
  clean_interval = '30'
  clean_limit = '356M'
  clean_service = 'htcacheclean'
  apache_service_redhat = 'httpd'
  apache_service_debian = 'apache2'
  systemd_apache_required_dir = '/etc/systemd/system/httpd.service.requires'
  systemd_apache_required_file = 'htcacheclean.service'
  systemd_htcacheclean_service_file = '/usr/lib/systemd/system/htcacheclean.service'
  
  context "Should fail for unsupported CentOS version" do
    let(:facts) { {
      :operatingsystem => "CentOS",
      :osfamily => "RedHat",
      :operatingsystemmajrelease => fail_operatingsystemrelease
      } }
    let(:params) { {
      :cache_directory => cache_directory,
      } }
    
    it do
      should compile.and_raise_error(/htcacheclean - Unsupported RHEL\/CentOS Version: #{fail_operatingsystemrelease}/)
    end
  end

  context "Should fail for unsupported OS" do
    let(:facts) { {
      :osfamily => fail_operatintsystem,
      } }
    let(:params) { {
      :cache_directory => cache_directory,
      } }
    
    it do
      should compile.and_raise_error(/htcacheclean - Unsupported Operating System Family: #{fail_operatintsystem}/)
    end
  end

  context "Should configure on CentOS" do
    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystemmajrelease => '7',
      :operatingsystem => 'CentOS'
      } }
    let(:params) { {
      :cache_directory => cache_directory,
      :clean_limit => clean_limit,
      :clean_interval => clean_interval,
      } }

    it do
      should contain_file(config_file)
      htcacheclean_config = catalogue().resource('file', config_file).send(:parameters)[:content]
      expect(File.read('spec/files/htcacheclean')).to eq(htcacheclean_config)
      should contain_service(clean_service).with(
          'ensure' => 'running'
      )
      should contain_exec('restart_apache').with(
          'refreshonly' => 'true'
      )
      should contain_file("#{systemd_apache_required_dir}/#{systemd_apache_required_file}").with(
          'ensure' => 'link',
          'target' => systemd_htcacheclean_service_file
      )
      should contain_file(systemd_apache_required_dir).with(
          'ensure' => 'directory'
      )
    end
  end


end
