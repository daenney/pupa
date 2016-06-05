require 'spec_helper'

describe 'profile::monitoring' do
  let(:pre_condition) {
    'include apt'
  }
  let(:facts) { {
    :osfamily => 'Debian',
    :concat_basedir => '/tmp',
    :lsbdistcodename => 'trusty',
    :lsbdistid => 'Ubuntu',
    :lsbdistrelease => '14.04',
    :networking => { :interfaces => { :eth0 => { :ip => '127.0.0.1',
                                                 :ip6 => '::1',}}},
  }}

  it { is_expected.to contain_class('collectd') }
  it { is_expected.to contain_class('facette') }

  it { is_expected.to contain_class('collectd::plugin::cpu') }
  it { is_expected.to contain_class('collectd::plugin::df') }
  it { is_expected.to contain_class('collectd::plugin::interface') }
  it { is_expected.to contain_class('collectd::plugin::load') }
  it { is_expected.to contain_class('collectd::plugin::memory') }
  it { is_expected.to contain_class('collectd::plugin::processes') }
  it { is_expected.to contain_class('collectd::plugin::rrdtool') }
  it { is_expected.to contain_class('collectd::plugin::users') }
  it { is_expected.to contain_class('collectd::plugin::syslog') }
  it { is_expected.to contain_class('collectd::plugin::ping') }

  it { is_expected.to contain_profile__firewall__allow('allow-world-facette').with({
    :port => 12003,
  })}
end
