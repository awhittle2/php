php_install 'php' do
  install_type 'package'
  action :install
end

apt_update 'update'
