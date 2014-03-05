if defined?(ChefSpec)
  def add_strider_user(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:strider_user, :add, resource_name)
  end
end
