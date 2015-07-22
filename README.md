# Pupa

Pupa is a few things:

* Heavily inspired by [puppetinabox](https://github.com/puppetinabox/documentation)
* Named after a haunted [doll](http://www.nightwatchparanormal.com/pupa-the-haunted-doll.html)
* Licensed under the Apache License, Version 2.0
* A script to bootstrap a masterless (puppet apply) installation of Puppet 4
  with r10k
* Puppet manifests for my personal machines

## pupa (the script)

The script in `bootstrap/` and the associated configuration there will take care
of getting your server ready to rumble with Puppet 4. It will use the Puppet 4
AIO packages to install Puppet and will use the version of Ruby and `gem`
provided by that package in `/opt/puppetlabs` to install additional dependencies
like r10k.

This has been designed to work with Debian/Ubuntu systems. It will go up in
flames if you try to run this on anything else including other Debian
derivatives for which the [Puppetlabs APT repository](https://apt.puppetlabs.com)
does not provide a [Puppet Collection](https://puppetlabs.com/blog/welcome-puppet-collections)
release package.

What this script will attempt to do:

* Complain loudly at you if something we need is missing
* Fetch the release deb from the Puppetlabs APT mirror
* Install it (so that we get new sources.list.d entries)
* Refresh the APT sources
* Install the `puppet-agent` package
* Write configuration for:
  * puppet: Set up some defaults for masterless mode
  * hiera: Set up the hierarchy
  * mcollective: Disables it
  * r10k: Set up where to clone environments from and how to deploy them

### usage

In order to use Pupa:

* fork this repository
* edit `bootstrap/r10k.yaml` and make the `remote` key point to your fork
* edit `bootstrap/hiera.yaml` to your liking
* edit `bootstrap/puppet.conf` to your liking
* rsync this to a server
* run `boostrap/pupa`

Assuming nothing blew up you now have a functioning Puppet 4 installation. If
something did go wrong you can tell Pupa to be a bit more verbose and instead
run `PUPA_LOGLEVEL=DEBUG bootstrap/pupa`.

## pupa (the configuration)

The configuration contained here is my own but might be a good start or good fit
for you too. However, before you actually run this on your machine you should
inspect and modify:

* Anything within the `dist/` directory (my roles and profiles)
* Anything within the `hiera/` directory (my hiera data)

## usage

Once you've made the necessary changes and updated the Pupa checkout on your
machines you should invoke `r10k` to deploy your environment followed by Puppet:
* `/opt/puppetlabs/puppet/bin/r10k deploy environment -p`
* `/opt/puppetlabs/puppet/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp`

## Developing

The provided `Gemfile` will take care of installing Puppet, Facter, Hiera, r10k
etc locally for you so you can work on manifests, run the tests and so forth.

```
$ bundle install
 Fetching gem metadata from https://rubygems.org/...........
 Fetching version metadata from https://rubygems.org/...
 Fetching dependency metadata from https://rubygems.org/..
 Resolving dependencies...
 [..]
 Bundle complete! 4 Gemfile dependencies, 17 gems now installed.
 Use `bundle show [gemname]` to see where a bundled gem is installed.
```

## Contributing

Contributions to both the bootstrap script and my configuration are always very
welcome. Any change however should be motivated with a good explanation of why
this change is necessary and generally have commits that:

* Are written in the imperative style
* Where a single commit represents a single feature
* Have a short subject
* Include as much text as needed in the body to motivate this change

Note that I will freely reject changes to both the `hiera/` and the `dist/`
trees. Even though your suggested changes might make sense in the grand scheme
of things they represent my opinion as to how I like to configure my machines
and as such I'd highly recommend raising an issue about it first to discuss the
changes beforehand.
