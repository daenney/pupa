require 'spec_helper'

describe 'profile::pupa::packages' do
  it { is_expected.to contain_package('fish').with({
    :ensure  => 'latest',
    :require => 'Apt::Source[fish]',
  })}

  it { is_expected.to contain_package('weechat').with({
    :ensure  => 'latest',
    :require => 'Apt::Source[weechat]',
  })}

  it { is_expected.to contain_package('tmux').with_ensure('latest')}
end
