package { 'r10k':
  ensure => '2.0.2',
  provider => 'puppet_gem',
}

file { '/etc/puppetlabs/r10k':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
}

file { '/var/cache/r10k':
  ensure => 'directory',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
}

file { '/etc/puppetlabs/r10k/r10k.yaml':
  ensure => 'file',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => "${pupadir}/r10k.yaml",
}
