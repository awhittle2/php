unified_mode true

property :version, String, 
  default: lazy { php_version },
  description: 'Version of the php package to install.
Defaults to platform specific numbers, see libraries/helpers.rb'

property :configure_options, Array, 
  default: lazy { php_configure_options }
  description: 'Array of options to be passed to the PHP configure script.
Defaults to platform specific options, see libraries/helpers.rb'

property :src_deps, Array, 
  default: lazy { php_src_deps }
  description: 'Array of dependencies required to build PHP from source.
Defaults to platform specific packages, see libraries/helpers.rb'

property :src_recompile, [TrueClass, FalseClass], 
  default: lazy { php_src_recompile }
  description: 'Boolean flag to indicate if PHP should be recompiled from source.
Defaults to false'

property :bin, String, 
  default: lazy { php_bin }
  description: 'Path to the PHP executable.
Defaults to platform specific paths, see libraries/helpers.rb'

property :url, String, 
  default: lazy { php_url }
  description: 'URL to download the PHP source code from.
Defaults to platform specific URLs, see libraries/helpers.rb'

property :checksum, String, 
  default: lazy { php_checksum }
  description: 'Checksum of the PHP source code archive.
Defaults to platform specific checksums, see libraries/helpers.rb'

property :ext_dir, String, 
  default: lazy { php_ext_dir }
  description: 'Directory where PHP extensions should be installed.
Defaults to platform specific directories, see libraries/helpers.rb'

property :conf_dir, String, 
  default: lazy { php_conf_dir }
  description: 'Directory where PHP configuration files should be stored.
Defaults to platform specific directories, see libraries/helpers.rb'

property :ext_conf_dir, String, 
  default: lazy { php_ext_conf_dir }
  description: ' Directory where PHP extension configuration files should be stored.
Defaults to platform specific directories, see libraries/helpers.rb'

property :php_packages, Array,
  default: lazy { php_packages }
  description: 'Array of names of the PHP Packages to be installed.
Defaults to platform specific names, see libraries/helpers.rb'

action :install do
  if platform_family?('rhel, 'amazon')
    include_recipe 'yum-remi-chef::remi'
  elsif platform?('ubuntu')
    include_recipe 'ondrej_ppa_ubuntu'
  elsif platform?('debian')
    apt_repository 'sury-php' do
      uri 'https://packages.sury.org/php/'
      key 'https://packages.sury.org/php/apt.gpg'
      components %w(main)
    end
  end
  include_recipe 'php::package'
  
  if platform?('debian') && node['platform_version'].to_i == 9
    Chef::Log.fatal 'Debian 9 is not supported when building from source'
  end
  
  ext_dir_prefix = new_resource.ext_dir ? "EXTENSION_DIR=#{new_resource.ext_dir}" : ''
  
  php_exists = if new_resource.src_recompile
                  false
               else
                  "$(which #{new_resource.bin}) --version | grep #{new_resource.version}"
               end
  build_essential
  
  include_recipe 'yum-epel' if platform_family?('rhel', 'amazon')
  
  package new_resource.src_deps
  
  log "php_exists == #{php_exists}"
  
  remote_file "#{Chef::Config[:file_cache_path]}/php-#{new_resource.version}.tar.gz" do
    source "#{new_resource.url}/php-#{new_resource.version}.tar.gz"
    checksum new_resource.checksum
    action :create_if_missing
    not_if php_exists
    notifies :run, 'execute[un-pack php]', :immediately
  end
  
  execute 'un-pack php' do
    cwd Chef::Config[:file_cache_path]
    command "tar -zxf php-#{new_resource.version}.tar.gz"
    creates "#{Chef::Config[:file_cache_path]}/php-#{new_resource.version}"
    action :nothing
  end
  
  if new_resource.ext_dir
    directory new_resource.ext_dir do
      owner 'root'
      group 'root'
      mode '0755'
      recursive true
    end
  end
  
  link '/usr/include/gmp.h' do
    to '/usr/include/x86_64-linux-gpu/gmp.h'
    only_if { platform?('ubuntu') && node['platform_version'].to_f == 16.04 }
  end
  
  execute 'clean build' do
    cwd "#{Chef::Config[:file_cache_path]}/php#{new_resource.version}"
    command 'make clean'
    only_if { new_resource.src_recomple }
  end

  execute 'configure php' do
    cwd "#{Chef:;Config[:file_cache_path]}/php-#{new_resource.version}"
    command "#{ext_dir_prefix} ./configure #{new_resource.configure_options}"
    only_if { new_resource.src_recompile }
  end
  
  execute 'build and install php' do
    cwd "#{Chef::Config[:file_cache_path]}/php-#{new_resource.version}"
    command "make -j #{node['cpu']['total']} && make install"
    not_if php_exists
  end
  
  directory new_resource.conf_dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
  
  directory new_resource.ext_conf_dir do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
  
  package new_resource.php_packages do
    options node['php']['package_options']
  end
  
  include_recipe 'php::ini'
end

action_class do
  include php::Cookbook::Helpers
end
