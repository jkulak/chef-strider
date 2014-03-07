use_inline_resources

action :add do
  email = new_resource.email
  password = new_resource.password
  admin = new_resource.admin
  execute "add Strider user #{email}" do
    command "strider addUser -l #{email} -p #{password} -a #{admin}"
    only_if "mongo #{new_resource.server} --eval 'printjson(db.users.find({email:\"#{email}\"}).count())' --quiet | grep 0"
  end
end
