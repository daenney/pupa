class role::base {
  aio_binstub { 'puppet': }
  aio_binstub { 'r10k': }
  aio_binstub { 'hiera': }
  aio_binstub { 'facter': }
  aio_binstub { 'eyaml': }
  aio_binstub { 'gem': prefix => 'puppet', }
  aio_binstub { 'irb': prefix => 'puppet', }

  $cron_minutes = [5, 15, 25, 35, 45, 55]
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
    require => Aio_binstub['r10k']
  }

  cron { 'puppet apply':
    ensure  => 'present',
    command => '/usr/local/bin/puppet apply /etc/puppetlabs/code/environments/production/manifets/site.pp > /var/log/puppetlabs/puppet/apply.log 2>&1',
    user    => 'root',
    minute  => $cron_minutes.map |$x| { $x + 2 },
    require => Aio_binstub['puppet']
  }
}
