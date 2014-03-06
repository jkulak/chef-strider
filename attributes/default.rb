default['strider']['user']           = 'strider'
default['strider']['group']          = 'strider'

default['strider']['root_dir']       = '/opt/strider'
default['strider']['git_repo']       = 'https://github.com/Strider-CD/strider.git'
default['strider']['git_target']     = 'master'

default['mongodb']['port']           = 27020
default['strider']['db-uri']         = "mongodb://localhost:#{default['mongodb']['port']}/strider-foss"
default['strider']['server-name']    = "https://#{node['fqdn']}"
default['strider']['port']           = 4000

# Data bag setup
default['strider']['data_bags'] = {
  'github' => {
    'enabled' => false,
    'data_bag' => 'secrets',
    'data_bag_item' => 'strider-github-app'
  },
  'bitbucket' => {
    'enabled' => false,
    'data_bag' => 'secrets',
    'data_bag_item' => 'strider-bitbucket-app'
  },
  'smtp' => {
    'enabled' => false,
    'data_bag' => 'credentials',
    'data_bag_item' => 'strider-smtp'
  }
}

# Node attributes if we aren't using a data bag
default['strider']['github'] = {
  'client_id'     => nil,
  'client_secret' => nil,
  'hostname'     => default['strider']['server-name']
}

default['strider']['bitbucket'] = {
  'app_key'      => nil,
  'app_secret'   => nil,
  'hostname'     => default['strider']['server-name']
}

default['strider']['smtp'] = {
  'host' => nil,
  'port' => 587,
  'user' => nil,
  'pass' => nil,
  'from' => "Strider <strider@#{node['fqdn']}>"
}

default['strider']['admin-email']    = "admin@#{node['fqdn']}"
default['strider']['admin-password'] = 'password'

default['strider']['init_type'] = value_for_platform(
  %w{ ubuntu } => {
    'default' => 'upstart'
  },
  'default' => 'forever'
)
