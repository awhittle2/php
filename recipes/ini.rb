#
# Author::  Christo De Lange (<opscode@dldinternet.com>)
# Cookbook:: php
# Recipe:: ini
#
# Copyright:: 2011-2021, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

config 'example' do
  fpm_service 'php-fpm'
  fpm_ini_control true
  fpm_conf_dir '/etc/php/7.2/fpm'
  ini_template 'php.ini.erb'
  ini_cookbook 'php'
  directives [
    { name: 'display_errors', value: 'Off' },
    { name: 'memory_limit', value: '256M' },
  ]
end
