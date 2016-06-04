require 'spec_helper'

describe 'profile::ssh' do
  let(:facts) { {
    :osfamily => 'Debian',
    :concat_basedir => '/tmp',
    :networking => { :interfaces => { :eth0 => { :ip => '127.0.0.1',
                                                 :ip6 => '::1',}}},
  }}
  it { is_expected.to contain_class('ssh') }
  it { is_expected.to contain_file('/etc/ssh/moduli').with({
    :ensure => 'file',
    :owner   => 'root',
    :group   => 'root',
    :mode    => '0644',
    :content => 'potato ba-boy',
    :notify  => 'Class[Ssh::Server::Service]',
  })}
  it { is_expected.to contain_profile__firewall__allow('allow-world-ssh').with({
    :port => 22,
  })}
end
