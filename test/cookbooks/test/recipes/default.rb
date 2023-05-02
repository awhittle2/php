apt_update 'update'

php_install 'php' do
  install_type 'package'
  action :install
end
