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
