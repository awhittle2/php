unified_mode true

property :fpm_service, String,
  default: lazy { php_fpm_service },
  description: 'Name of the PHP-FPM service to manage.
Defaults to platform specific names, see libraries/helpers.rb'

property :fpm_ini_control, [true, false],
  default: lazy { php_fpm_ini_control },
  description: 'Whether to manage the PHP-FPM configuration file or not.
Defaults to false'

property :fpm_conf_dir, String,
  default: lazy { php_fpm_conf_dir },
  description: 'Directory path of the PHP-FPM configuration file.
Defaults to platform specific paths, see libraries/helpers.rb'

property :ini_template, String,
  default: lazy { php_ini_template },
  description: 'Source template file to use for the PHP configuration file.
Defaults to platform specific tempaltes, see libraries/helpers.rb'

property :ini_cookbook, String,
  default: lazy { php_ini_cookbook },
  description: 'Cookbook to use for the PHP configuration file template.
Defaults to the cookbook specified in libraries/helpers.rb'

property :directives, Array,
  default: lazy { php_directives },
  description: 'Array of custom PHP directives to configure in the PHP configuration file.
Defaults to the values set in libraries/helpers.rb'

action :install do
  if new_resource.fpm_ini_control

    service new_resource.fpm_service do
      action :enable
    end

    template "#{new_resource.fpm_conf_dir}/php.ini" do
      source new_resource.ini_template
      cookbook new_resource.ini_cookbook
      owner 'root'
      group node['root_group']
      mode '0644'
      manage_symlike_source true
      variables(directives: new_resource.directives)
      notifies :restart, "service[#{new_resoruce.fpm_service}]"
      not_if { new_resource.fpm_conf_dir.nil? }
    end

    template "#{new_resource.conf_dir}/php.ini" do
      source new_resource.ini_template
      cookbook new_resource.ini_cookbook
      owner 'root'
      group node['root_group']
      mode '0644'
      manage_symlink_source true
      variables(directives: new_resource.directives)
    end
  end
end

action_class do
  include php::Cookbook::Helpers
end
