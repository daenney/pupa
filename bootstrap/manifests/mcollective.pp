file { '/etc/puppetlabs/mcollective':
  ensure  => 'directory',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  purge   => true,
  recurse => true,
}

file { '/etc/puppetlabs/mcollective/server.cfg':
  ensure => 'file',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
}

file { '/etc/puppetlabs/mcollective/client.cfg':
  ensure => 'file',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
}
