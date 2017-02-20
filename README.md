# spacewalk_client Module
[![Build Status](https://travis-ci.org/Adaptavist/puppet-htcacheclean.svg?branch=master)](https://travis-ci.org/Adaptavist/puppet-htcacheclean)
## Overview

The **htcacheclean** module handles the configuration and enabling of htcacheclean

**Currently only RHEL/Centos 7 is supported**

## Configuration

`htcacheclean::cache_directory`

The cache directory that htcacheclean is going to manage

`htcacheclean::config_file`

The main htcacheclean configuration file, defaults to **/etc/sysconfig/htcacheclean**

`htcacheclean::config_template`

The location of a htcacheclean configuration erb template, defaults to **htcacheclean/htcacheclean.erb**

`htcacheclean::clean_interval`

The interval to run cleanups, defauts to **30**

`htcacheclean::clean_limit`

The size limit of the cache, defaults to **1024M**

`htcacheclean::clean_service`

The name of the htcacheclean service, defaults to **htcacheclean**

`htcacheclean::apache_service`

The name of the apache service, defaults to **httpd**

`htcacheclean::additional_options`

Additional options to pass to htcacheclean, default is none

`htcacheclean::systemd_apache_required_dir`

The systemd directory that holds a list of services that apache requires, defaults to **/etc/systemd/system/httpd.service.requires**

`htcacheclean::systemd_apache_required_file`

The location of the htcache clean service file that is crated as a symlink into the apache requires directory, defaults to **/etc/systemd/system/httpd.service.requires/htcacheclean.service**

`htcacheclean::systemd_htcacheclean_service_file`

The systemd unit file that defines the htcacheclean service, defaults to **/usr/lib/systemd/system/htcacheclean.service**

## Dependencies

This module depends on the following puppet modules:

* puppetlabs/stdlib

