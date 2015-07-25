class profile::ssh {
  contain ::ssh

  file { '/etc/ssh/moduli':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => hiera('ssh_moduli'),
    notify  => Class[':ssh::server::service']
  }
}
