name              'php'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Installs and maintains php and php modules'
source_url        'https://github.com/sous-chefs/php'
issues_url        'https://github.com/sous-chefs/php/issues'
chef_version      '>= 14.0'
version           '8.1.2'

depends 'yum-epel'
depends 'yum-remi-chef'
depends 'ondrej_ppa_ubuntu'

supports 'amazon', '>= 2.0'
supports 'centos', '>= 7.0'
supports 'debian', '>= 9.0'
supports 'oracle', '>= 7.0'
supports 'redhat', '>= 7.0'
supports 'scientific', '>= 7.0'
supports 'ubuntu', '>= 16.04'
