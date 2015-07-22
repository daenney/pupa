file { '/etc/puppetlabs/mcollective':
  ensure  => 'directory',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  purge   => true,
  recurse => true,
}
