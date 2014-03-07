actions :add
default_action :add

attribute :email, :name_attribute => true, :kind_of => String
attribute :password, :kind_of => String, :default => ''
attribute :admin, :kind_of => [TrueClass, FalseClass], :default => false
attribute :server, :kind_of => String, :default => 'localhost/strider-foss'
