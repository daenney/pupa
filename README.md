# Pupa [![Travis](https://img.shields.io/travis/daenney/pupa.svg?style=flat-square)](https://travis-ci.org/daenney/pupa)

Pupa is a few things:

* Heavily inspired by [puppetinabox](https://github.com/puppetinabox/documentation)
* Named after a [haunted doll](http://www.nightwatchparanormal.com/pupa-the-haunted-doll.html)
* Licensed under the [Apache License, Version 2.0](LICENSE)
* A [script](bootstrap/pupa) to bootstrap a masterless (puppet apply) installation of Puppet 4
  with r10k
* Puppet [manifests](dist) for my personal machines

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
* Install the `puppet-agent` package (Puppet, cfacter, Facter, mcollective,
  Hiera)
* Install r10k and hiera-eyaml
* Write configuration for:
  * puppet: Set up some defaults for masterless mode
  * hiera: Set up the hierarchy
  * mcollective: Disables it
  * r10k: Set up where to clone environments from and how to deploy them

### idempotency

Pupa tries to be fairly intelligent. If you have a look at the code you'll see
that it does its best not to install packages or refresh sources if it detects
it's not needed.

Once Puppet is installed we use it to configure the rest of the system for us.
Though we incur a slight runtime penalty from calling Puppet a couple of times
we gain all the benefits, including idempotency.

This means this script can be run in a continuous loop not ever taking any
action that modifies the system except if its source files have been updated.

### usage

In order to use Pupa:

* fork this repository
* edit `bootstrap/r10k.yaml` and make the `remote` key point to your fork
* edit `bootstrap/hiera.yaml` to your liking
* edit `bootstrap/puppet.conf` to your liking
* `git clone` your fork to your server (over HTTPS is easiest and requires no
  authentication if it's a public repo)
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

### usage

Once you've made the necessary changes and updated the Pupa checkout on your
machines you need to:

* Run `r10k` to deploy your environment(s)
* Run `puppet apply` to apply the configuration

If everything went fine you should see something like this:

```
$ /opt/puppetlabs/puppet/bin/r10k deploy environment -pv
INFO	 -> Deploying environment /etc/puppetlabs/code/environments/production
$ /opt/puppetlabs/puppet/bin/puppet apply /etc/puppetlabs/code/environments/production/manifests/site.pp
Notice: Compiled catalog for localhost in environment production in 0.71 seconds
Notice: Applied catalog in 0.04 seconds
```

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

The Gemfile also installs puppet-lint, the puppetlabs_spec_helper gem and a
bunch of puppet-lint plugins. These will help you to check your manifests for
things like syntax errors and style errors or run the rspec tests.

A number of tasks are defined by the Rakefile:

```
$ rake -vT
rake beaker            # Run beaker acceptance tests
[..]
rake validate          # Check syntax of Ruby files and call :syntax and :metadata
```

You'll most likely want to use the `test` task:

```
$ rake test
---> syntax:manifests
---> syntax:templates
---> syntax:hiera:yaml
---> lint
---> spec: dist/profile
[..]

Finished in 1 second (files took 0.77317 seconds to load)
15 examples, 0 failures
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
