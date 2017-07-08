package { 'hiera-eyaml':
  ensure   => '2.1.0',
  provider => 'puppet_gem',
}

package { 'deep_merge':
  ensure   => '1.1.1',
  provider => 'puppet_gem',
}

$base_path = '/etc/puppetlabs'

file { "${base_path}/puppet/eyaml":
  ensure => directory,
  owner  => 'root',
  group  => 'root',
  mode   => '0500',
}

file { "${base_path}/puppet/hiera.yaml":
  ensure => absent,
}

# Set up production environment
$code_path = "${base_path}/code"
$env_path = "${code_path}/environments"
$prod_path = "${env_path}/production"
$env_setup = [
  $code_path,
  $env_path,
  $prod_path,
  "${prod_path}/modules",
  "${prod_path}/manifests",
  "${prod_path}/data",
]

$env_setup.each | String $path | {
  file { $path:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}

file { "${prod_path}/hiera.yaml":
  ensure => 'file',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => "${pupadir}/hiera.yaml",
}
