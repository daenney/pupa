class role::base {
  include ::apt
  include ::unattended_upgrades
  include ::profile::monitoring
  include ::profile::ssh
  include ::profile::pupa
  include ::profile::firewall
  include ::ntp
}
