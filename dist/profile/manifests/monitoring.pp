class profile::monitoring {
  include ::facette

  include ::collectd
  include ::collectd::plugin::cpu
  include ::collectd::plugin::df
  include ::collectd::plugin::interface
  include ::collectd::plugin::load
  include ::collectd::plugin::memory
  include ::collectd::plugin::processes
  include ::collectd::plugin::rrdtool
  include ::collectd::plugin::users
  include ::collectd::plugin::syslog

  ::collectd::plugin::ping { 'irc':
    hosts    => hiera('collectd::plugin::ping::irc'),
    interval => hiera('collectd::plugin::ping::interval'),
  }
}
