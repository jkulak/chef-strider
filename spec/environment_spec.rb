require 'spec_helper'

describe 'strider::environment' do
  let(:chef_runner) do
    ChefSpec::Runner.new(step_into: ['user']) do |node|
      node.set['strider'] = strider_attributes
    end
  end
  let(:chef_run) { chef_runner.converge(described_recipe) }

  it 'should create a .env file in the strider user\'s home directory' do
    expect(chef_run).to create_template('/home/strider/.env').with(source:'dotenv.erb')
  end
end
