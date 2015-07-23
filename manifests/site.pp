Exec {
  path      => $facts['path'],
  logoutput => 'on_failure',
}

require ::role::base
hiera_include('classes', [])
