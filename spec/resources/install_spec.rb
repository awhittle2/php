require 'spec_helper'

describe 'php_install' do
  step_into :php_install, :php_config
  platform 'ubuntu'
  
 context 'install PHP with default properties' do
   recipe do
     php_install 'package'
     
     service 'php' do
       service_name lazy { php_platform_service_name }
       supports restart: true, status: true, reload: true
       action :nothing
     end
   end
   
   it 'has a correct configuration file' do
     is_expected.to create_template('/etc/php/7.4/fpm/php.ini').with_variables(
       memory_limit: '128M',
       error_reporting: 'E_ALL & ~E_DEPRECATED & ~E_STRICT',
       display_errors: 'Off',
       post_max_size: '8M',
       upload_max_filesize: '2M',
       max_file_uploads: 20,
       max_input_time: 60,
       date_timezone: 'UTC'
      )
    end
  end
end
