class role::base {
  include ::apt
  include ::profile::ssh
  include ::profile::pupa
}
