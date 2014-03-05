name             'strider'
maintainer       'Stafford Brunk'
maintainer_email 'stafford.brunk@gmail.com'
license          'All rights reserved'
description      'Installs/Configures Strider continuous deployment'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.4.3'

recipe "strider::default", "Installs and configures Strider-CD"
recipe "strider::environemnt", "Generates a .env file for Strider-CD in the strider user's home directory"
recipe "strider::users", "Creates Strider-CD users as specified by node attributes"
recipe "strider::forever", "Uses forever for running Strider-CD"
recipe "strider::upstart", "Users uptstart for running Strider-CD"

supports 'ubuntu'

depends 'user'
depends 'npm'
depends 'nodejs'
depends 'mongodb'
depends 'git'
