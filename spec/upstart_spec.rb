require 'spec_helper'

describe 'strider::upstart' do
  let(:chef_runner) do
    ChefSpec::Runner.new do |node|
      node.set['strider'] = strider_attributes
    end
  end
  let(:chef_run) { chef_runner.converge(described_recipe) }

  it 'should create the strider upstart service' do
    expect(chef_run).to create_template('/etc/init/strider.conf').with(
      source: 'upstart/strider.conf.erb'
    )
  end

  it 'should enable the strider service' do
    expect(chef_run).to enable_service('strider').with(
      #provider: Chef::Provider::Service::Upstart,
      supports: {restart: true, start: true, stop: true, status: true}
    )
  end


  it 'should start the strider service' do
    expect(chef_run).to start_service('strider').with(
      #provider: Chef::Provider::Service::Upstart,
      supports: {restart: true, start: true, stop: true, status: true}
    )
  end
end
