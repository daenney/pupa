Exec {
  path      => $facts['path'],
  logoutput => 'on_failure',
}

hiera_include('classes', [])
