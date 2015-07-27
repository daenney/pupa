require 'spec_helper'

describe 'aio_binstub' do
  let(:title) { 'gem' }
  context 'default' do
    it { is_expected.to contain_file('/usr/local/bin/gem').with({
      :ensure  => 'file',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0755',
      :content => "#!/usr/bin/env bash\n\nexec \"/opt/puppetlabs/puppet/bin/gem\" \"$@\"\n",
    })}
  end

  context 'with prefix' do
    let(:params) { { :prefix => 'puppet', } }
    it { is_expected.to contain_file('/usr/local/bin/puppet-gem').with({
      :ensure  => 'file',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0755',
      :content => "#!/usr/bin/env bash\n\nexec \"/opt/puppetlabs/puppet/bin/gem\" \"$@\"\n",
    })}
  end

  context 'with plbin' do
    let(:params) { { :plbin => '/sw/puppetlabs/bin', } }
    it { is_expected.to contain_file('/usr/local/bin/gem').with({
      :ensure  => 'file',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0755',
      :content => "#!/usr/bin/env bash\n\nexec \"/sw/puppetlabs/bin/gem\" \"$@\"\n",
    })}
  end

  context 'with target' do
    let(:params) { { :target => '/usr/bin', } }
    it { is_expected.to contain_file('/usr/bin/gem').with({
      :ensure  => 'file',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0755',
      :content => "#!/usr/bin/env bash\n\nexec \"/opt/puppetlabs/puppet/bin/gem\" \"$@\"\n",
    })}
  end
end
