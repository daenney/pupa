require 'spec_helper'

describe 'profile::firewall' do
  let(:facts) { {:osfamily => 'Debian' } }
  it { is_expected.to contain_class('ufw') }
end
