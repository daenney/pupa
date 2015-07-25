require 'spec_helper'

describe 'profile::pupa::cron' do
  it { is_expected.to contain_cron('pdeploy').with({
    :ensure  => 'present',
    :command => /pdeploy production/,
    :minute  => [5, 15, 25, 35, 45, 55],
    :require => 'Class[Profile::Pupa::Binstub]',
  })}
end
