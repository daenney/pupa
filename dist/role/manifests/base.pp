class role::base {
  include ::apt
  include ::profile::monitoring
  include ::profile::ssh
  include ::profile::pupa
  include ::ntp
}
