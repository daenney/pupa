# Obligatory class with random packages I always want
class profile::pupa::packages {
  $p_opts = { 'ensure' => 'latest', }

  package { 'fish':
    *       => $p_opts,
    require => Apt::Source['fish'],
  }

  package { 'tmux': * => $p_opts, }
}
