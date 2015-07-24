class profile::pupa::cron {
  cron { 'pdeploy':
    ensure  => 'present',
    command => '/usr/local/bin/pdeploy production > /var/log/puppetlabs/puppet/pdeploy.log 2>&1',
    minute  => range(5, 55, 10),
    require => Class['::profile::pupa::binstub'],
  }
}
