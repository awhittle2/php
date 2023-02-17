require 'spec_helper'
require_relative '../../libraries/helpers'

RSpec.describe Php::Cookbook::Helpers do
  class DummyClass < Chef::Node
    include Php::Cookbook::Helpers
  end

  subject { DummyClass.new }

  describe '#php_version' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_version).to eq '7.2.31' }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_version).to eq '7.2.31' }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_version).to eq '7.2.31' }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      before { allow(platform_version).to receive(:to_i).and_return(10) }
      it { expect(subject.php_version).to eq '7.3.19' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      before { allow(platform_version).to receive(:to_i).and_return(11) }
      it { expect(subject.php_version).to eq '7.4.27' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      before { allow(platform_version).to receive(:to_f).and_return(18.04) }
      it { expect(subject.php_version).to eq '7.2.31' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      before { allow(platform_version).to receive(:to_f).and_return(20.04) }
      it { expect(subject.php_version).to eq '7.4.7' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      before { allow(platform_version).to receive(:to_f).and_return(22.04) }
      it { expect(subject.php_version).to eq '8.1.7' }
    end
  end

  describe '#php_checksum' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { 7 }
      it { expect(subject.php_checksum).to eq '796837831ccebf00dc15921ed327cfbac59177da41b33044d9a6c7134cdd250c' }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_checksum).to eq '796837831ccebf00dc15921ed327cfbac59177da41b33044d9a6c7134cdd250c' }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_checksum).to eq '796837831ccebf00dc15921ed327cfbac59177da41b33044d9a6c7134cdd250c' }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_checksum).to eq '809126b46d62a1a06c2d5a0f9d7ba61aba40e165f24d2d185396d0f9646d3280' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_checksum).to eq '564fd5bc9850370db0cb4058d9087f2f40177fa4921ce698a375416db9ab43ca' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_checksum).to eq '796837831ccebf00dc15921ed327cfbac59177da41b33044d9a6c7134cdd250c' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.php_checksum).to eq 'a554a510190e726ebe7157fb00b4aceabdb50c679430510a3b93cbf5d7546e44' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.php_checksum).to eq '5f0b422a117633c86d48d028934b8dc078309d4247e7565ea34b2686189abdd8' }
    end
  end

  describe '#php_conf_dir' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_conf_dir).to eq '/etc' }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_conf_dir).to eq '/etc' }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_conf_dir).to eq '/etc' }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_conf_dir).to eq '/etc/php/7.3/cli' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_conf_dir).to eq '/etc/php/7.4/cli' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_conf_dir).to eq '/etc/php/7.2/cli' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.php_conf_dir).to eq '/etc/php/7.4/cli' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.php_conf_dir).to eq '/etc/php/8.1/cli' }
    end
  end

  describe '#php_src_deps' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it {
        expect(subject.php_src_deps).to eq %w(bzip2-devel libc-client-devel libcurl-devel freetype-devel gmp-devel libjpeg-devel krb5-devel
               libmcrypt-devel libpng-devel openssl-devel t1lib-devel libxml2-devel libxslt-devel zlib-devel mhash-devel)
      }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it {
        expect(subject.php_src_deps).to eq %w(bzip2-devel libc-client-devel curl-devel freetype-devel gmp-devel libjpeg-devel krb5-devel
               libmcrypt-devel libpng-devel openssl-devel libxml2-devel libxslt-devel zlib-devel mhash-devel)
      }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it {
        expect(subject.php_src_deps).to eq %w(bzip2-devel libc-client-devel libcurl-devel freetype-devel gmp-devel libjpeg-devel krb5-devel
               libmcrypt-devel libpng-devel openssl-devel t1lib-devel libxml2-devel libxslt-devel zlib-devel mhash-devel)
      }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it {
        expect(subject.php_src_deps).to eq %w(libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-turbo-dev
               libkrb5-dev libmcrypt-dev libpng-dev libssl-dev pkg-config libxml2-dev file re2c libzip-dev)
      }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it {
        expect(subject.php_src_deps).to eq %w(libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-turbo-dev
               libkrb5-dev libmcrypt-dev libonig-dev libpng-dev libsqlite3-dev libssl-dev pkg-config libxml2-dev file re2c libzip-dev)
      }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it {
        expect(subject.php_src_deps).to eq %w(libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev
               libkrb5-dev libmcrypt-dev libpng-dev libssl-dev pkg-config libxml2-dev)
      }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it {
        expect(subject.php_src_deps).to eq %w(libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev
               libkrb5-dev libmcrypt-dev libpng-dev libssl-dev pkg-config libxml2-dev libsqlite3-dev libonig-dev)
      }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it {
        expect(subject.php_src_deps).to eq %w(libbz2-dev libc-client2007e-dev libcurl4-gnutls-dev libfreetype6-dev libgmp3-dev libjpeg62-dev
               libkrb5-dev libmcrypt-dev libpng-dev libssl-dev pkg-config libxml2-dev libsqlite3-dev libonig-dev)
      }
    end
  end

  describe '#php_packages' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_packages).to eq %w(php php-devel php-cli php-pear) }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_packages).to eq %w(php php-devel php-cli php-pear) }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_packages).to eq %w(php php-devel php-cli php-pear) }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_packages).to eq %w(php-cgi php php-dev php-cli php-pear) }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_packages).to eq %w(php-cgi php php-dev php-cli php-pear) }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_packages).to eq %w(php7.2-cgi php7.2 php7.2-dev php7.2-cli php-pear) }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.packages).to eq %w(php7.4-cgi php7.4 php7.4-dev php7.4-cli php-pear) }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.packages).to eq %w(php8.1-cgi php8.1 php8.1-dev php8.1-cli php-pear) }
    end
  end

  describe '#php_fpm_default_conf' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_fpm_default_conf).to eq '/etc/php-fpm.d/www.conf' }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_fpm_default_conf).to eq '/etc/php-fpm.d/www.conf' }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_fpm_default_conf).to eq '/etc/php-fpm.d/www.conf' }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_fpm_default_conf).to eq '/etc/php/7.3/fpm/pool.d/www.conf' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_fpm_default_conf).to eq '/etc/php/7.4/fpm/pool.d/www.conf' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_fpm_default_conf).to eq '/etc/php/7.2/fpm/pool.d/www.conf' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.php_fpm_default_conf).to eq '/etc/php/7.4/fpm/pool.d/www.conf' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.php_fpm_default_conf).to eq '/etc/php/8.1/fpm/pool.d/www.conf' }
    end
  end

  describe '#php_fpm_conf_dir' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_fpm_conf_dir).to be_nil }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_fpm_conf_dir).to be_nil }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_fpm_conf_dir).to be_nil }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_fpm_conf_dir).to eq '/etc/php/7.3/fpm' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_fpm_conf_dir).to eq '/etc/php/7.4/fpm' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_fpm_conf_dir).to eq '/etc/php/7.2/fpm' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.php_fpm_conf_dir).to eq '/etc/php/7.4/fpm' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.php_fpm_conf_dir).to eq '/etc/php/8.1/fpm' }
    end
  end

  describe '#php_ext_conf_dir' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_ext_conf_dir).to eq '/etc/php.d' }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_ext_conf_dir).to eq '/etc/php.d' }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_ext_conf_dir).to eq '/etc/php.d' }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_ext_conf_dir).to eq '/etc/php/7.3/mods-available' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_ext_conf_dir).to eq '/etc/php/7.4/mods-available' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_ext_conf_dir).to eq '/etc/php/7.2/mods-available' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.php_ext_conf_dir).to eq '/etc/php/7.4/mods-available' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.php_ext_conf_dir).to eq '/etc/php/8.1/mods-available' }
    end
  end

  describe '#php_fpm_package' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_fpm_package).to eq 'php-fpm' }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_fpm_package).to eq 'php-fpm' }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_fpm_package).to eq 'php-fpm' }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_fpm_package).to eq 'php7.3-fpm' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_fpm_package).to eq 'php7.4-fpm' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_fpm_package).to eq 'php7.2-fpm' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.php_fpm_package).to eq 'php7.4-fpm' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.php_fpm_package).to eq 'php8.1-fpm' }
    end
  end

  describe '#php_fpm_pooldir' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_fpm_pooldir).to eq '/etc/php-fpm.d' }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_fpm_pooldir).to eq '/etc/php-fpm.d' }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_fpm_pooldir).to eq '/etc/php-fpm.d' }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_fpm_pooldir).to eq '/etc/php/7.3/fpm/pool.d' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_fpm_pooldir).to eq '/etc/php/7.4/fpm/pool.d' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_fpm_pooldir).to eq '/etc/php/7.2/fpm/pool.d' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.php_fpm_pooldir).to eq '/etc/php/7.4/fpm/pool.d' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.php_fpm_pooldir).to eq '/etc/php/8.1/fpm/pool.d' }
    end
  end

  describe '#php_fpm_service' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_fpm_service).to eq 'php-fpm' }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_fpm_service).to eq 'php-fpm' }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_fpm_service).to eq 'php-fpm' }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_fpm_service).to eq 'php7.3-fpm' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_fpm_service).to eq 'php7.4-fpm' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_fpm_service).to eq 'php7.2-fpm' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.php_fpm_service).to eq 'php7.4-fpm' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.php_fpm_service).to eq 'php8.1-fpm' }
    end
  end

  describe '#php_fpm_socket' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('platform_version').and_return(platform_version)
    end

    context 'rhel 7' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '7' }
      it { expect(subject.php_fpm_socket).to eq '/var/run/php7.2-fpm.sock' }
    end

    context 'rhel 8' do
      let(:platform_family) { 'rhel' }
      let(:platform_version) { '8' }
      it { expect(subject.php_fpm_socket).to eq '/var/run/php7.2-fpm.sock' }
    end

    context 'amazon 2' do
      let(:platform_family) { 'amazon' }
      let(:platform_version) { '2' }
      it { expect(subject.php_fpm_socket).to eq '/var/run/php7.2-fpm.sock' }
    end

    context 'debian 10' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '10' }
      it { expect(subject.php_fpm_socket).to eq '/var/run/php/php7.3-fpm.sock' }
    end

    context 'debian 11' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '11' }
      it { expect(subject.php_fpm_socket).to eq '/var/run/php/php7.4-fpm.sock' }
    end

    context 'ubuntu 18.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '18.04' }
      it { expect(subject.php_fpm_socket).to eq '/var/run/php/php7.2-fpm.sock' }
    end

    context 'ubuntu 20.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '20.04' }
      it { expect(subject.php_fpm_socket).to eq '/var/run/php/php7.4-fpm.sock' }
    end

    context 'ubuntu 22.04' do
      let(:platform_family) { 'debian' }
      let(:platform_version) { '22.04' }
      it { expect(subject.php_fpm_socket).to eq '/var/run/php/php8.1-fpm.sock' }
    end
  end

  describe '#php_fpm_user' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('php_install_method').and_return(php_install_method)
    end

    context 'rhel' do
      let(:platform_family) { 'rhel' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_user).to eq 'apache' }
    end

    context 'amazon' do
      let(:platform_family) { 'amazon' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_user).to eq 'apache' }
    end

    context 'rhel' do
      let(:platform_family) { 'rhel' }
      let(:php_install_method) { 'source' }
      it { expect(subject.php_fpm_user).to eq 'nobody' }
    end

    context 'amazon' do
      let(:platform_family) { 'amazon' }
      let(:php_install_method) { 'source' }
      it { expect(subject.php_fpm_user).to eq 'nobody' }
    end

    context 'debian' do
      let(:platform_family) { 'debian' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_user).to eq 'www-data' }
    end
  end

  describe '#php_fpm_group' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('php_install_method').and_return(php_install_method)
    end

    context 'rhel' do
      let(:platform_family) { 'rhel' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_group).to eq 'apache' }
    end

    context 'amazon' do
      let(:platform_family) { 'amazon' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_group).to eq 'apache' }
    end

    context 'rhel' do
      let(:platform_family) { 'rhel' }
      let(:php_install_method) { 'source' }
      it { expect(subject.php_fpm_group).to eq 'nobody' }
    end

    context 'amazon' do
      let(:platform_family) { 'amazon' }
      let(:php_install_method) { 'source' }
      it { expect(subject.php_fpm_group).to eq 'nobody' }
    end

    context 'debian' do
      let(:platform_family) { 'debian' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_group).to eq 'www-data' }
    end
  end

  describe '#php_fpm_listen_user' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('php_install_method').and_return(php_install_method)
    end

    context 'rhel' do
      let(:platform_family) { 'rhel' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_listen_user).to eq 'apache' }
    end

    context 'amazon' do
      let(:platform_family) { 'amazon' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_listen_user).to eq 'apache' }
    end

    context 'rhel' do
      let(:platform_family) { 'rhel' }
      let(:php_install_method) { 'source' }
      it { expect(subject.php_fpm_listen_user).to eq 'nobody' }
    end

    context 'amazon' do
      let(:platform_family) { 'amazon' }
      let(:php_install_method) { 'source' }
      it { expect(subject.php_fpm_listen_user).to eq 'nobody' }
    end

    context 'debian' do
      let(:platform_family) { 'debian' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_listen_user).to eq 'www-data' }
    end
  end

  describe '#php_fpm_listen_group' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('php_install_method').and_return(php_install_method)
    end

    context 'rhel' do
      let(:platform_family) { 'rhel' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_listen_group).to eq 'apache' }
    end

    context 'amazon' do
      let(:platform_family) { 'amazon' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_listen_group).to eq 'apache' }
    end

    context 'rhel' do
      let(:platform_family) { 'rhel' }
      let(:php_install_method) { 'source' }
      it { expect(subject.php_fpm_listen_group).to eq 'nobody' }
    end

    context 'amazon' do
      let(:platform_family) { 'amazon' }
      let(:php_install_method) { 'source' }
      it { expect(subject.php_fpm_listen_group).to eq 'nobody' }
    end

    context 'debian' do
      let(:platform_family) { 'debian' }
      let(:php_install_method) { 'package' }
      it { expect(subject.php_fpm_listen_group).to eq 'www-data' }
    end
  end

  describe '#php_install_method' do
    it { expect(subject.php_install_method).to eq 'package' }
  end

  describe '#php_directives' do
    it { expect(subject.php_directives).to eq {} }
  end

  describe '#php_bin' do
    it { expect(subject.php_bin).to eq 'php' }
  end

  describe '#php_pecl' do
    it { expect(subject.php_pecl).to eq 'pecl' }
  end

  describe '#php_pear' do
    it { expect(subject.php_pear).to eq '/usr/bin/pear' }
  end

  describe '#php_pear_setup' do
    it { expect(subject.php_pear_setup).to eq true }
  end

  describe '#php_pear_channels' do
    it { expect(subject.php_pear_channels).to eq ['pear.php.net', 'pecl.php.net'] }
  end

  describe '#php_url' do
    it { expect(subject.php_url).to eq 'https://www.php.net/distributions' }
  end

  describe '#php_prefix_dir' do
    it { expect(subject.php_prefix_dir).to eq '/urs/local' }
  end

  describe '#php_ini_template' do
    it { expect(subject.php_ini_template).to eq 'php.ini.erb' }
  end

  describe '#php_ini_cookbook' do
    it { expect(subject.php_ini_cookbook).to eq 'php' }
  end

  describe '#php_fpm_ini_control' do
    it { expect(subject.php_fpm_ini_control).to eq false }
  end

  describe '#php_src_recompile' do
    it { expect(subject.php_src_recompile).to eq false }
  end

  describe '#php_ext_dir' do
    before do
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
      allow(subject).to receive(:[]).with('php_lib_dir').and_return(php_lib_dir)
    end

    context 'rhel lib64' do
      let(:platform_family) { 'rhel' }
      let(:php_lib_dir) { 'lib64' }
      it { expect(subject.php_ext_dir).to eq '/usr/lib64/php/modules' }
    end

    context 'amazon lib64' do
      let(:platform_family) { 'amazon' }
      let(:php_lib_dir) { 'lib64' }
      it { expect(subject.php_ext_dir).to eq '/usr/lib64/php/modules' }
    end

    context 'rhel lib' do
      let(:platform_family) { 'rhel' }
      let(:php_lib_dir) { 'lib' }
      it { expect(subject.php_ext_dir).to eq '/usr/lib/php/modules' }
    end

    context 'amazon lib' do
      let(:platform_family) { 'amazon' }
      let(:php_lib_dir) { 'lib' }
      it { expect(subject.php_ext_dir).to eq '/usr/lib/php/modules' }
    end

    context 'debian' do
      let(:platform_family) { 'debian' }
      let(:php_lib_dir) { 'lib' }
      it { expect(subject.php_ext_dir).to be_nil }
    end
  end

  describe '#php_disable_mod' do
    it { expect(subject.php_disable_mod).to eq '/usr/sbin/phpdismod' }
  end

  describe '#php_enable_mod' do
    it { expect(subject.php_enable_mod).to eq '/usr/sbin/phpenmod' }
  end

  describe '#lib_dir' do
    before do
      allow(subject).to receive(:[]).with('kernel').and_return(kernel)
      allow(subject).to receive(:[]).with('platform_family').and_return(platform_family)
    end

    context 'rhel x86_64' do
      let(:kernel) { { 'machine' => 'x86_64' } }
      let(:platform_family) { 'rhel' }
      it { expect(subject.lib_dir).to eq '/usr/lib64/php' }
    end

    context 'rhel i686' do
      let(:kernel) { { 'machine' => 'i686' } }
      let(:platform_family) { 'rhel' }
      it { expect(subject.lib_dir).to eq '/usr/lib/php' }
    end

    context 'amazon x86_64' do
      let(:kernel) { { 'machine' => 'x86_64' } }
      let(:platform_family) { 'amazon' }
      it { expect(subject.lib_dir).to eq '/usr/lib64/php' }
    end

    context 'amazon i686' do
      let(:kernel) { { 'machine' => 'i686' } }
      let(:platform_family) { 'amazon' }
      it { expect(subject.lib_dir).to eq '/usr/lib/php' }
    end

    context 'debian' do
      let(:kernel) { { 'machine' => 'x86_64' } }
      let(:platform_family) { 'debian' }
      it { expect(subject.lib_dir).to eq 'lib' }
    end
  end
end
