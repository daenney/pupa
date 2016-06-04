require 'spec_helper'

describe 'profile::pupa::packages' do
  let(:facts) {{
    :networking => { :interfaces => { :eth0 => { :ip => '127.0.0.1',
                                                 :ip6 => '::1',}}},
  }}
  it { is_expected.to contain_package('fish').with({
    :ensure  => 'latest',
    :require => 'Apt::Source[fish]',
  })}

  it { is_expected.to contain_package('weechat').with({
    :ensure  => 'latest',
    :require => 'Apt::Source[weechat]',
  })}

  it { is_expected.to contain_package('tmux').with({
    :ensure  => 'latest',
    :require => 'Apt::Source[pirho]',
  })}

end
