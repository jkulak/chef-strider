#
# Cookbook Name:: strider
# Recipe:: default
#
# Copyright (C) 2014 Stafford Brunk
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "git"
include_recipe "nodejs::npm"
include_recipe "user"
include_recipe "mongodb" if node['strider']['mongodb']['install']

user_account node["strider"]["user"] do
  comment "Strider CD user"
end

group node["strider"]["group"] do
  action :modify
  members [
    node["strider"]["user"]
  ]
end

git node['strider']['root_dir'] do
  repository node['strider']['git_repo']
  reference node['strider']['git_target']
  group node["strider"]["group"]
  action :sync
end

execute "npm update Strider" do
  command "npm update"
  cwd node['strider']['root_dir']
  creates "#{node['strider']['root_dir']}/node_modules"
  group node["strider"]["group"]
  action :run
end

link "/usr/local/bin/strider" do
  to "#{node['strider']['root_dir']}/bin/strider"
  group node["strider"]["group"]
end

include_recipe "strider::environment"
include_recipe "strider::users"
include_recipe "strider::#{node['strider']['init_type']}"
