#
# Cookbook Name:: strider
# Recipe:: forever
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

execute "npm install forever" do
  command "npm install forever -g"
  creates "/usr/local/bin/forever"
end

execute "start Strider with Forever" do
  command "forever start --pidFile /var/run/strider.pid -l /var/log/forever.log -o /var/log/strider-out.log -e /var/log/strider-error.log bin/strider"
  cwd node["strider"]["root_dir"]
  creates "/var/run/strider.pid"
end
