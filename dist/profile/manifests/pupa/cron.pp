class profile::pupa::cron {
  $cron_minutes = range(5, 55, 10)
  cron { 'git pull pupa':
    ensure  => 'present',
    command => 'cd /var/cache/pupa && /usr/bin/git reset --hard HEAD && /usr/bin/git pull > /var/log/puppetlabs/puppet/pupa.log 2>&1',
    user    => 'root',
    minute  => $cron_minutes,
  }

  cron { 'r10k deploy':
    ensure  => 'present',
    command => '/usr/local/bin/r10k deploy environment -pv > /var/log/puppetlabs/puppet/r10k.log 2>&1',
    user    => 'root',
    minute  => $cron_minutes.map |$x| { $x + 1 },
    require => Class['::profile::puppa::binstub'],
  }

  cron { 'puppet apply':
    ensure  => 'present',
    command => '/usr/local/bin/papply production > /var/log/puppetlabs/puppet/apply.log 2>&1',
    user    => 'root',
    minute  => $cron_minutes.map |$x| { $x + 2 },
    require => Class['::profile::puppa::binstub'],
  }
}
