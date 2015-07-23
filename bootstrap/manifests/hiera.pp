package { 'hiera-eyaml':
  ensure   => '2.0.8',
  provider => 'puppet_gem',
}

package { 'deep_merge':
  ensure   => '1.0.1',
  provider => 'puppet_gem',
}

file { '/etc/puppetlabs/keys':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0500',
}

file { '/etc/puppetlabs/code/hiera.yaml':
  ensure => 'file',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => "${pupadir}/hiera.yaml",
}
