require 'spec_helper'

describe 'strider::forever' do
  let(:chef_runner) do
    ChefSpec::Runner.new do |node|
      node.set['strider'] = strider_attributes
    end
  end
  let(:chef_run) { chef_runner.converge(described_recipe) }

  it 'should install the Forever NPM module' do
    expect(chef_run).to run_execute('npm install forever').with(
      command: 'npm install forever -g',
      creates: '/usr/local/bin/forever'
    )
  end

  it 'should start strider with Forever' do
    expect(chef_run).to run_execute('start Strider with Forever').with(
      command: 'forever start --pidFile /var/run/strider.pid -l /var/log/forever.log -o /var/log/strider-out.log -e /var/log/strider-error.log bin/strider',
      cwd: '/opt/strider',
      creates: '/var/run/strider.pid'
    )
  end
end

