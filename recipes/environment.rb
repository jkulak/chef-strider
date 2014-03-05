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

default['strider']['data_bag']       = 'secrets'
default['strider']['data_bag_item']  = 'strider-github-app'

github_app = = Chef::EncryptedDataBagItem.load(node['strider']['data_bag'], node['strider']['data_bag_item'])

template "/home/#{node['strider']['user']}/.env" do
  source 'dotenv.erb'
  variables(
    github_app: github_app
  )
end
