class profile::monitoring {
  include ::facette

  include ::collectd
  include ::collectd::cpu
  include ::collectd::df
  include ::collectd::interface
  include ::collectd::load
  include ::collectd::memory
  include ::collectd::ping
  include ::collectd::processes
  include ::collectd::rrdtool
  include ::collectd::users
  include ::collectd::syslog
}
