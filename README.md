# chef-strider [![Build Status](https://travis-ci.org/wingrunr21/chef-strider.png)](https://travis-ci.org/wingrunr21/chef-strider)
This cookbook installs and configures [Strider CD](https://github.com/Strider-CD/strider)

## Requirements

### Packages
- NodeJS
- MongoDB

### Cookbooks

- user
- npm
- nodejs
- mongodb
- git

### Platform

Ubuntu

Tested on:

* Ubuntu 12.04, 13.10

## Usage

Just include `strider` in your node's `run_list`:

    {
      "name":"my_node",
      "run_list": [
        "recipe[strider]"
      ]
    }

This will install and configure Strider-CD on your node. See below for
configuration settings

## Configuration

You will want to define some type of user for Strider at the very least:

    default['strider']['users'] = {
      'user@example.com' => {
        'password' => 'abc123',
        'admin' => true
      }
    }

## Attributes

Under `node['strider']`

Attribute | Description | Type | Default
----------|-------------|------|--------
user | The system user Strider will run under | String | strider
group | The system group Strider will run under | String | strider
root_dir | The root directory of the Strider checkout | String | `/opt/strider`
git_repo | The git repo from which Strider will be cloned | String | https://github.com/Strider-CD/strider.git'
git_target | The git target which will be checked out | String | `master`
db-uri | The mongodb database Strider will use | String | mongodb://localhost/strider-foss 
server-name | The server's name | String | `node['fqdn']`
port | The port Strider will use | String | 4000

#### GitHub application setup:

Attribute | Description | Type | Default
----------|-------------|------|--------
data_bag | The data bag Chef will look in for the GitHub app credentials | String | secrets
data_bag_item | The data bag item Chef will look in for the GitHub app credentials | String | strider-github-app

#### Init type

Attribute | Description | Type | Default
----------|-------------|------|--------
init_type | Init system to use to run Strider | String | upstart for Ubuntu systems, [forever](https://github.com/nodejitsu/forever) for everyone else

#### SMTP setup (`node['strider']['smtp']`):

Attribute | Description | Type | Default
----------|-------------|------|--------
host | The SMTP server's hostname | String | `nil`
port | The SMTP server's port | Integer | 587
user | The SMTP username | String | `nil`
pass | The SMTP password | String | `nil`
from | The SMTP from address | String | Strider \<strider@`node['fqdn']`\>

#### Users (`node['strider']['users']`)

The users hash has the following structure:

    default['strider']['users'] = {
      'user1@example.com' => {
        'password' => 'abc123',
        'admin' => true
      },
      'user1@example.com' => {
        'password' => 'abc123',
        'admin' => false
      }
    }

# TODO
1. Add [serverspec](http://serverspec.org/) tests to test-kitchen

# Author

Author: Stafford Brunk ([wingrunr21](https://github.com/wingrunr21))
