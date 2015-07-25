require 'spec_helper'

describe 'profile::ssh' do
  let(:facts) { {:osfamily => 'debian', :concat_basedir => '/tmp' } }
  it { is_expected.to contain_class('ssh') }
  it { is_expected.to contain_file('/etc/ssh/moduli').with({
    :ensure => 'file',
    :owner   => 'root',
    :group   => 'root',
    :mode    => '0644',
    :content => 'potato ba-boy',
    :notify  => 'Class[Ssh::Server::Service]',
  })}
end
