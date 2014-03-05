require 'spec_helper'

describe 'strider::default' do
  let(:chef_runner) do
    ChefSpec::Runner.new do |node|
      node.set['strider'] = strider_attributes
    end
  end
  let(:chef_run) { chef_runner.converge(described_recipe) }

  before do
    stub_command("/usr/local/bin/npm -v 2>&1 | grep '1.3.5'").and_return(false)
  end

  it 'includes the git recipe' do
    expect(chef_run).to include_recipe('git')
  end

  it 'includes the nodejs::npm recipe' do
    expect(chef_run).to include_recipe('nodejs::npm')
  end

  it 'includes the mongodb recipe' do
    expect(chef_run).to include_recipe('mongodb')
  end

  it 'includes the user recipe' do
    expect(chef_run).to include_recipe('user')
  end

  it 'creates the strider user' do
    expect(chef_run).to create_user_account('strider')
  end

  it 'adds the strider user to the specified strider group' do
    expect(chef_run).to modify_group('strider-group').with(
      members: ['strider']
    )
  end

  it 'syncs with the Strider-CD repository' do
    expect(chef_run).to sync_git('/opt/strider').with(repository: 'git://github.com/Strider-CD/strider.git',
                                                      reference: 'master',
                                                      group: 'strider-group')
  end

  it 'should execute npm update in the Strider directory' do
    expect(chef_run).to run_execute('npm update Strider').with(
      command: 'npm update',
      cwd: '/opt/strider',
      creates: '/opt/strider/node_modules',
      group: 'strider-group'
    )
  end

  it 'should symlink the strider binary to /usr/local/bin' do
    expect(chef_run).to create_link('/usr/local/bin/strider').with(to:'/opt/strider/bin/strider',
                                                                   group:'strider-group')
  end

  it 'should include the strider::environment recipe' do
    expect(chef_run).to include_recipe('strider::environment')
  end

  it 'should include the users strider::users recipe' do
    expect(chef_run).to include_recipe('strider::users')
  end


  describe 'when not running on an ubuntu installation' do
    let(:chef_runner) do
      ChefSpec::Runner.new(platform:'centos', version:'6.5') do |node|
        node.set['strider'] = strider_attributes
      end
    end

    it 'should include the strider::forever recipe' do
      expect(chef_run).to include_recipe('strider::forever')
    end
  end

  describe 'when running on an ubuntu installation' do
    it 'should include the strider::upstart recipe' do
      expect(chef_run).to include_recipe('strider::upstart')
    end
  end
end
