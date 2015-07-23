class role::base {
  aio_binstub { 'puppet': }
  aio_binstub { 'r10k': }
  aio_binstub { 'hiera': }
  aio_binstub { 'facter': }
  aio_binstub { 'eyaml': }
  aio_binstub { 'gem': prefix => 'puppet', }
  aio_binstub { 'irb': prefix => 'puppet', }
}
