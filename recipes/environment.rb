#
# Cookbook Name:: strider
# Recipe:: environment
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

# Extract service creds
data_bags = node['strider']['data_bags']
creds = {}
%w{github bitbucket smtp}.each do |service|
  if data_bags[service]['enabled']
    bag = Chef::EncryptedDataBagItem.load(data_bags[service]['data_bag'], data_bags[service]['data_bag_item'])
  else
    bag = node['strider'][service] 
  end

  creds[service] = bag
end

template "/home/#{node['strider']['user']}/.env" do
  source 'dotenv.erb'
  variables(
    credentials: creds 
  )
end
