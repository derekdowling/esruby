name             'esruby'
maintainer       'Derek Dowling'
maintainer_email 'me@derekdowling.com'
license          'apache2'
description      'Installs/Configures Elastic Search'
long_description 'Installs/Configures ES'
version          '0.1.1'

depends "java"
depends "ufw"
depends "firewall", "= 0.11.8"
depends "elasticsearch"
depends "apt"
depends "nginx"
depends "kibana"
