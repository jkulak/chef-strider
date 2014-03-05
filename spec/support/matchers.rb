# Shim support for user cookbook LWRP
module UserCookbookLWRPMatchers
  def create_user_account(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:user_account, :create, resource_name)
  end
end

include UserCookbookLWRPMatchers
