define profile::firewall::allow(
  Variant[String[1], Integer] $port,
  Enum[tcp, udp] $proto = 'tcp',
  Any $from = 'any',
  Any $ensure = 'present',
) {

  ::ufw::allow { "${title}-v4":
    ensure => $ensure,
    proto  => $proto,
    port   => "${port}", #lint:ignore:only_variable_string
    ip     => $::facts['networking']['interfaces']['eth0']['ip'],
    from   => $from,
  }

  ::ufw::allow { "${title}-v6":
    ensure => $ensure,
    proto  => $proto,
    port   => "${port}", #lint:ignore:only_variable_string
    ip     => $::facts['networking']['interfaces']['eth0']['ip6'],
    from   => $from,
  }
}
