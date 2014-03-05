require 'spec_helper'

describe 'strider::environment' do
  let(:chef_runner) do
    ChefSpec::Runner.new(step_into: ['user']) do |node|
      node.set['strider'] = strider_attributes
    end
  end
  let(:chef_run) { chef_runner.converge(described_recipe) }

  context 'when using data bags for service credentials' do
    let(:chef_runner) do
      ChefSpec::Runner.new(step_into: ['user']) do |node|
        node.set['strider'] = strider_attributes.merge({
          'data_bags' => {
            'github' => {
              'enabled' => true,
              'data_bag' => 'secrets',
              'data_bag_item' => 'strider-github-app'
            },
            'bitbucket' => {
              'enabled' => true,
              'data_bag' => 'secrets',
              'data_bag_item' => 'strider-bitbucket-app'
            },
            'smtp' => {
              'enabled' => true,
              'data_bag' => 'credentials',
              'data_bag_item' => 'strider-smtp'
            }
          }
        })
      end
    end

    before do
      Chef::EncryptedDataBagItem.stub(:load).with('secrets', 'strider-github-app').and_return(strider_data_bags['github'])
      Chef::EncryptedDataBagItem.stub(:load).with('secrets', 'strider-bitbucket-app').and_return(strider_data_bags['bitbucket'])
      Chef::EncryptedDataBagItem.stub(:load).with('credentials', 'strider-smtp').and_return(strider_data_bags['smtp'])
    end
    
    it 'should render .env with the data bag data' do
      expect(chef_run).to create_template('/home/strider/.env').with(source:'dotenv.erb', variables:{credentials:strider_data_bags})
    end
  end

  context 'when using node attributes for service credentials' do
    it 'should render .env with the data bag data' do
      expect(chef_run).to create_template('/home/strider/.env').with(source:'dotenv.erb', variables:{credentials:strider_service_credentials})
    end
  end
end
