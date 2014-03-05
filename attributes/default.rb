default['strider']['user']           = 'strider'
default['strider']['group']          = 'strider'

default['strider']['root_dir']       = '/opt/strider'
default['strider']['git_repo']       = 'https://github.com/Strider-CD/strider.git'
default['strider']['git_target']     = 'master'

default['strider']['db-uri']         = 'mongodb://localhost/strider-foss'
default['strider']['server-name']    = node['fqdn']
default['strider']['port']           = 4000

default['strider']['data_bag']       = 'secrets'
default['strider']['data_bag_item']  = 'strider-github-app'

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
