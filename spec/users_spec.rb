require 'spec_helper'

describe 'strider::users' do
  let(:chef_runner) do
    ChefSpec::Runner.new(step_into: ['strider_user']) do |node|
      node.set['strider'] = strider_attributes.merge(strider_users)
    end
  end
  let(:chef_run) { chef_runner.converge(described_recipe) }

  let(:commands) do
    strider_users['users'].map do |email, attr|
      "mongo strider-foss --eval 'printjson(db.users.find({email:\"#{email}\"}).count())' --quiet | grep 0"
    end
  end

  strider_users['users'].each do |email, attr|
    context "when the user #{email} does not exist" do
      before do
        commands.each do |command|
          stub_command(command).and_return(true)
        end
      end

      it 'should add the user' do
        expect(chef_run).to run_execute("add Strider user #{email}").with(
          command: "strider addUser -l #{email} -p #{attr['password']} -a #{attr['admin']}"
        )
      end
    end

    context "when the user #{email} does exist" do
      before do
        commands.each do |command|
          stub_command(command).and_return(false)
        end
      end

      it 'should not add the user' do
        expect(chef_run).to_not run_execute("add Strider user #{email}")
      end
    end
  end
end
