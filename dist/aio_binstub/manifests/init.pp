define aio_binstub (
  $plbin = '/opt/puppetlabs/puppet/bin',
  $target = '/usr/local/bin',
  $prefix = undef,
) {

  if $prefix {
    $stub = "${prefix}-${title}"
  } else {
    $stub = $title
  }

  file { $stub:
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    path    => "${target}/${stub}",
    content => "#!/usr/bin/env bash\n\nexec \"${plbin}/${title}\" \"$@\"",
  }
}
