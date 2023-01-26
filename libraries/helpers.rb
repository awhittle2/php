# frozen_string_literal: true

module Php
  module Cookbook
    module Helpers
      def lib_dir
        arch = node['kernel']['machine']

        if platform_family?('rhel', 'amazon')
          if arc =~ /x86_64/
            '/usr/lib64/php'
          else
            '/usr/lib/php'
          end
        else
          'lib'
        end
      end

      def php_version
        case node['platform']
        when 'debian'
          if node['platform_version'].to_i == 10
            '7.3.19'
          elsif node['platform_version'].to_i >= 11
            '7.4.27'
          end
        when 'ubuntu'
          if node['platform_version'].to_f == 18.04
            '7.2.31'
          elsif node['platform_version'].to_f == 20.04
            '7.4.7'
          elsif node['platform_version'].to_f >= 22.04
            '8.1.7'
          end
        else
          if node['platform-family'] == 'debian'
            '7.0.4'
          else
            '7.2.31'
          end
        end
      end

      def php_checksum
        case node['platform']
        when 'debian'
          if node['platform_version'].to_i == 10
            '809126b46d62a1a06c2d5a0f9d7ba61aba40e165f24d2d185396d0f9646d3280'
          elsif node['platform_version'].to_i >= 11
            '564fd5bc9850370db0cb4058d9087f2f40177fa4921ce698a375416db9ab43ca'
          end
        when 'ubuntu'
          if node['platform_version'].to_f == 18.04
            '796837831ccebf00dc15921ed327cfbac59177da41b33044d9a6c7134cdd250c'
          elsif node['platform_version'].to_f == 20.04
            'a554a510190e726ebe7157fb00b4aceabdb50c679430510a3b93cbf5d7546e44'
          elsif node['platform_version'].to_f >= 22.04
            '5f0b422a117633c86d48d028934b8dc078309d4247e7565ea34b2686189abdd8'
          end
        else
          if node['platform-family'] == 'debian'
            'f6cdac2fd37da0ac0bbcee0187d74b3719c2f83973dfe883d5cde81c356fe0a8'
          else
            '796837831ccebf00dc15921ed327cfbac59177da41b33044d9a6c7134cdd250c'
          end
        end
      end

      def php_conf_dir
        case node['platform_family']
        when 'rhel', 'amazon'
          '/etc'
        when 'debian'
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            '/etc/php/7.3/cli'
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            '/etc/php/7.4/cli'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            '/etc/php/7.2/cli'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            '/etc/php/7.4/cli'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            '/etc/php/8.1/cli'
          else
            '/etc/php/7.0/cli'
          end
        end
      end

      def php_src_deps
        case node['platform_family']
        when 'rhel', 'amazon'
          if node['platform'] == 'amazon' || node['platform_version'].to_i < 8
            %w[bzip2-devel libc-client-devel libcurl-devel freetype-devel gmp-devel libjpeg-devel krb5-devel
               libmcrypt-devel libpng-devel openssl-devel t1lib-devel libxml2-devel libxslt-devel zlib-devel mhash-devel]
          else
            %w[bzip2-devel libc-client-devel curl-devel freetype-devel gmp-devel libjpeg-devel krb5-devel
               libmcrypt-devel libpng-devel openssl-devel libxml2-devel libxslt-devel zlib-devel mhash-devel]
          end
        when 'debian'
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            %w[libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-turbo-dev
               libkrb5-dev libmcrypt-dev libpng-dev libssl-dev pkg-config libxml2-dev file re2c libzip-dev]
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            %w[libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-turbo-dev
               libkrb5-dev libmcrypt-dev libonig-dev libpng-dev libsqlite3-dev libssl-dev pkg-config libxml2-dev file re2c libzip-dev]
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            %w[libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev
               libkrb5-dev libmcrypt-dev libpng-dev libssl-dev pkg-config libxml2-dev]
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            %w[libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev
               libkrb5-dev libmcrypt-dev libpng-dev libssl-dev pkg-config libxml2-dev libsqlite3-dev libonig-dev]
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            %w[libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev
               libkrb5-dev libmcrypt-dev libpng-dev libssl-dev pkg-config libxml2-dev libsqlite3-dev libonig-dev]
          else
            %w[libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg-dev libkrb5-dev
               libmcrypt-dev libpng-dev libssl-dev pkg-config libxml2-dev]
          end
        end
      end

      def php_packages
        case node['platform-family']
        when 'rhel', 'amazon'
          %w[php php-devel php-cli php-pear]
        when 'debian'
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            %w[php-cgi php php-dev php-cli php-pear]
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            %w[php-cgi php php-dev php-cli php-pear]
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            %w[php7.2-cgi php7.2 php7.2-dev php7.2-cli php-pear]
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            %w[php7.4-cgi php7.4 php7.4-dev php7.4-cli php-pear]
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            %w[php8.1-cgi php8.1 php8.1-dev php8.1-cli php-pear]
          else
            %w[php7.0-cgi php7.0 php7.0-dev php7.0-cli php-pear]
          end
        end
      end

      def php_disable_mod
        if node['platform_family'] == 'debian'
          if node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
          end
        end
        '/usr/sbin/phpdismod'
      end

      def php_enable_mod
        if node['platform_family'] == 'debian'
          if node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
          end
        end
        '/usr/sbin/phpenmod'
      end

      def php_fpm_default_conf
        case node['platform_family']
        when 'rhel', 'amazon'
          '/etc/php-fpm.d/www.conf'
        when 'debian'
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            '/etc/php/7.3/fpm/pool.d/www.conf'
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            '/etc/php/7.4/fpm/pool.d/www.conf'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            '/etc/php/7.2/fpm/pool.d/www.conf'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            '/etc/php/7.4/fpm/pool.d/www.conf'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            '/etc/php/8.1/fpm/pool.d/www.conf'
          else
            '/etc/php/7.0/fpm/pool.d/www.conf'
          end
        end
      end

      def php_fpm_conf_dir
        if node['platform_family'] == 'debian'
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            '/etc/php/7.3/fpm'
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            '/etc/php/7.4/fpm'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            '/etc/php/7.2/fpm'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            '/etc/php/7.4/fpm'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            '/etc/php/8.1/fpm'
          else
            '/etc/php/7.0/fpm'
          end
        end
      end

      def php_ext_conf_dir
        case node['platform_family']
        when 'rhel', 'amazon'
          '/etc/php.d'
        when 'debian'
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            '/etc/php/7.3/mods-available'
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            '/etc/php/7.4/mods-available'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            '/etc/php/7.2/mods-available'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            '/etc/php/7.4/mods-available'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            '/etc/php/8.1/mods-available'
          else
            '/etc/php/7.0/mods-available'
          end
        end
      end

      def php_fpm_package
        case node['platform_family']
        when 'rhel', 'amazon'
          'php-fpm'
        when 'debian'
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            'php7.3-fpm'
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            'php7.4-fpm'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            'php7.2-fpm'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            'php7.4-fpm'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            'php8.1-fpm'
          else
            'php7.0-fpm'
          end
        end
      end

      def php_fpm_pooldir
        case node['platform_family']
        when 'rhel', 'amazon'
          '/etc/php-fpm.d'
        when 'debian'
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            '/etc/php/7.3/fpm/pool.d'
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            '/etc/php/7.4/fpm/pool.d'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            '/etc/php/7.2/fpm/pool.d'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            '/etc/php/7.4/fpm/pool.d'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            '/etc/php/8.1/fpm/pool.d'
          else
            '/etc/php/7.0/fpm/pool.d'
          end
        end
      end

      def php_fpm_service
        case node['platform_family']
        when 'rhel', 'amazon'
          'php-fpm'
        when 'debian'
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            'php7.3-fpm'
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            'php7.4-fpm'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            'php7.2-fpm'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            'php7.4-fpm'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            'php8.1-fpm'
          else
            'php7.0-fpm'
          end
        end
      end

      def php_fpm_socket
        if platform_family?('debian')
          if node['platform'] == 'debian' && node['platform_version'].to_i == 10
            '/var/run/php/php7.3-fpm.sock'
          elsif node['platform'] == 'debian' && node['platform_version'].to_i >= 11
            '/var/run/php/php7.4-fpm.sock'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 18.04
            '/var/run/php/php7.2-fpm.sock'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f == 20.04
            '/var/run/php/php7.4-fpm.sock'
          elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 22.04
            '/var/run/php/php8.1-fpm.sock'
          else
            '/var/run/php/php7.0-fpm.sock'
          end
        else
          '/var/run/php7.2-fpm.sock'
        end
      end

      def php_fpm_user
        case node['platform_family']
        when 'rhel', 'amazon'
          'nobody'
          'apache' if php_install_method == 'package'
        when 'debian'
          'www-data'
        end
      end

      def php_fpm_group
        case node['platform_family']
        when 'rhel', 'amazon'
          'nobody'
          'apache' if php_install_method == 'package'
        when 'debian'
          'www-data'
        end
      end

      def php_fpm_listen_user
        case node['platform_family']
        when 'rhel', 'amazon'
          'nobody'
          'apache' if php_install_method == 'package'
        when 'debian'
          'www-data'
        end
      end

      def php_fpm_listen_group
        case node['platform_family']
        when 'rhel', 'amazon'
          'nobody'
          'apache' if php_install_method == 'package'
        when 'debian'
          'www-data'
        end
      end

      def php_install_method
        'package'
      end

      def php_directives
        {}
      end

      def php_bin
        'php'
      end

      def php_pecl
        'pecl'
      end

      def php_pear
        '/usr/bin/pear'
      end

      def php_pear_setup
        true
      end

      def php_pear_channels
        [
          'pear.php.net',
          'pecl.php.net'
        ]
      end

      def php_url
        'https://www.php.net/distributions'
      end

      def php_prefix_dir
        '/urs/local'
      end

      def php_ini_template
        'php.ini.erb'
      end

      def php_ini_cookbook
        'php'
      end

      def php_fpm_ini_control
        false
      end

      def php_src_recompile
        false
      end

      def php_configure_options
        %W[--prefix=#{php_prefix_dir}
           --with-libdir=#{php_lib_dir}
           --with-config-file-path=#{php_conf_dir}
           --with-config-file-scan-dir=#{php_ext_conf_dir}
           --with-pear
           --enable-fpm
           --with-fpm-user=#{php_fpm_user}
           --with-fpm-group=#{php_fpm_group}
           --with-zlib
           --with-openssl
           --with-kerberos
           --with-bz2
           --with-curl
           --enable-ftp
           --enable-zip
           --enable-exif
           --with-gd
           --enable-gd-native-ttf
           --with-gettext
           --with-gmp
           --with-mhash
           --with-iconv
           --with-imap
           --with-imap-ssl
           --enable-sockets
           --enable-soap
           --with-xmlrpc
           --with-mcrypt
           --enable-mbstring]
      end

      def php_ext_dir
        "/usr/#{php_lib_dir}/php/modules" if node['platform_family'] == 'rhel' || node['platform_family'] == 'amazon'
      end
    end
  end
end
