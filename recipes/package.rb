#
# Author::  Seth Chisamore (<schisamo@chef.io>)
# Author::  Lucas Hansen (<lucash@chef.io>)
# Cookbook:: php
# Recipe:: package
#
# Author::  Jeff Byrnes (<thejeffbyrnes@gmail.com>)
# Cookbook:: php
# Recipe:: community_package
#
# Author::  Seth Chisamore (<schisamo@chef.io>)
# Cookbook:: php
# Recipe:: source
#
# Copyright:: 2021, Jeff Byrnes
#
# Copyright:: 2013-2021, Chef Software, Inc.
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

install 'example' do
  version '7.3.12'
  configure_options [
    '--with-config-file-path=/etc/php/7.3',
    '--with-fpm-user=www-data',
    '--with-fpm-group=www-data',
  ]
  src_deps %w(libxml2-devel openssl-devel)
  src_recompile false
  bin '/usr/local/bin/php'
  url 'https://www.php.net/distributions/php-7.3.12.tar.gz'
  checksum '2f6a6790e7cdba82dd94ab6bccd99ad16c9a1e94b253466ec2fdb611c7de8b44'
  ext_dir '/usr/local/lib/php/extensions/no-debug-non-zts-20180731'
  conf_dir '/etc/php/7.3'
  ext_conf_dir '/etc/php/7.3/conf.d'
  php_packages %w(php-fpm php-mysql php-xml)
end
