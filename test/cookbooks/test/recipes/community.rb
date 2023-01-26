::Chef::DSL::Recipe.include Php::Cookbook::Helpers

php_install 'php' do
  install_type 'package'
  community_package true
end

apt_update 'update'

include_recipe 'php'

# README: The Remi repo intentionally avoids installing the binaries to
#         the default paths. It comes with a /opt/remi/php80/enable profile
#         which can be copied or linked into /etc/profiles.d to auto-load for
#         operators in a real cookbook.
if platform_family?('rhel', 'amazon')
  link '/usr/bin/php' do
    to '/usr/bin/php80'
  end

  link '/usr/bin/php-pear' do
    to '/usr/bin/php80-pear'
  end

  link '/usr/bin/pecl' do
    to '/opt/remi/php80/root/bin/pecl'
  end

  link '/etc/profile.d/php80-enable.sh' do
    to '/opt/remi/php80/enable'
  end
end

# Create a test pool
php_fpm_pool 'test-pool' do
  action :install
end

# Add PEAR channel
php_pear_channel 'pear.php.net' do
  binary php_pear_path
  action :update
end

# Install https://pear.php.net/package/HTTP2
php_pear 'HTTP2' do
  binary php_pear_path
end

# Add PECL channel
php_pear_channel 'pecl.php.net' do
  binary php_pear_path
  action :update
end

# Install https://pecl.php.net/package/sync
php_pear 'sync-binary' do
  package_name 'sync'
  binary 'pecl'
  priority '50'
end
