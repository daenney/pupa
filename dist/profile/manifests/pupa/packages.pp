# Obligatory class with random packages I always want
class profile::pupa::packages {
  $p_opts = { 'ensure' => 'latest', }

  package { 'fish':
    *       => $p_opts,
    require => Apt::Source['fish'],
  }

  package { 'weechat':
    *       => $p_opts,
    require => Apt::Source['weechat'],
  }

  ::profile::firewall::allow { 'allow-world-weechat-relay':
    port  => '9001',
  }

  package { 'mosh':
    *       => $p_opts,
    require => Apt::Source['mosh'],
  }

  ::profile::firewall::allow { 'allow-world-mosh':
    port  => '60000:61000',
    proto => 'udp',
  }

  package { 'tmux':
    *       => $p_opts,
    require => Apt::Source['pirho'],
  }

  package { ['znc', 'znc-dev']:
    *       => $p_opts,
    require => Apt::Source['znc'],
  }

  ::profile::firewall::allow { 'allow-world-znc':
    port => 6697,
  }
}
