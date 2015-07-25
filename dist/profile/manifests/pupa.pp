# Configure other Pupa related things
class profile::pupa {
  contain ::profile::pupa::binstub
  contain ::profile::pupa::cron
  contain ::profile::pupa::packages
  contain ::profile::pupa::users
}
