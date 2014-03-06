require 'chefspec'
require 'chefspec/berkshelf'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '12.04'
  config.log_level = :error
end

def strider_attributes
  @strider_attributes ||= {
    git_repo: 'git://github.com/Strider-CD/strider.git',
    git_target: 'master',
    user: 'strider',
    group: 'strider-group'
  }
end

def strider_users
  @strider_users ||= {
    'users' => {
      'foo@example.com' => {
        'password' => 'abc123',
        'admin' => true
      },
      'bar@example.com' => {
        'password' => '123abc',
        'admin' => false
      }
    }
  }
end

def strider_service_credentials
  @strider_service_credentials ||= {
    'github' => {
      'client_id'     => nil,
      'client_secret' => nil,
      'hostname'     => 'https://fauxhai.local'
    },
    'bitbucket' => {
      'app_key'      => nil,
      'app_secret'   => nil,
      'hostname'     => 'https://fauxhai.local'
    },
    'smtp' => {
      'host' => nil,
      'port' => 587,
      'user' => nil,
      'pass' => nil,
      'from' => "Strider <strider@fauxhai.local>"
    }
  }
end

def strider_data_bags
  @strider_data_bags ||= {
    'github' => {
      'client_id'     => 'foo',
      'client_secret' => 'bar'
    },
    'bitbucket' => {
      'app_key'      => 'baz',
      'app_secret'   => 'batz'
    },
    'smtp' => {
      'host' => 'smtp.googlemail.com',
      'port' => 587,
      'user' => 'fake@example.com',
      'pass' => 'abc123',
      'from' => "Strider <strider@example.com>"
    }
  }
end
