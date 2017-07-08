# Pupa [![Travis](https://img.shields.io/travis/daenney/pupa.svg?style=flat-square)](https://travis-ci.org/daenney/pupa)

Pupa is a few things:

* Heavily inspired by [puppetinabox](https://github.com/puppetinabox/documentation)
* Named after a [haunted doll](http://www.nightwatchparanormal.com/pupa-the-haunted-doll.html)
* Licensed under the [Apache License, Version 2.0](LICENSE)
* A [script](bootstrap/pupa) to bootstrap a masterless (puppet apply) installation of Puppet 5
  with r10k

## pupa (the script)

The script in `bootstrap/` and the associated configuration there will take care
of getting your server ready to rumble with Puppet 5. It will use the Puppet 5
AIO packages to install Puppet and will use the version of Ruby and `gem`
provided by that package in `/opt/puppetlabs` to install additional dependencies
like r10k.

Contrary to previous version this repository no longer contains any of my
customisations. It does in the `Puppetfile` include a few "must have" libraries
and still includes a complete `Rakefile` to help you get going with
development. From there on out you're on your own but there's a lot of very
good [documentation available for Puppet 5](https://docs.puppet.com/puppet/5.0/).

**This has been designed to work with Debian/Ubuntu systems**. It will go up in
flames if you try to run this on anything else including other Debian
derivatives for which the [Puppetlabs APT repository](https://apt.puppetlabs.com)
does not provide a [Puppet 5](https://puppet.com/blog/puppet-5-platform-released)
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

Assuming nothing blew up you now have a functioning Puppet 5 installation. If
something did go wrong you can tell Pupa to be a bit more verbose and instead
run `PUPA_LOGLEVEL=DEBUG bootstrap/pupa`.

## Developing

The provided `Gemfile` will take care of installing Puppet, Facter, Hiera, r10k
etc. locally for you so you can work on manifests, run the tests and so forth.

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

The `Gemfile` also installs `puppet-lint` and the `puppetlabs_spec_helper`
gems. It used to include a number of additional plugins but most of these
only signal support for puppet-lint 1.x breaking the installation of the
bundle.

Please take a look at the [puppet-lint plugin list on Vox Pupuli](https://voxpupuli.org/plugins/#puppet-lint)
and pick which seem useful to you. Add those to the `Gemfile` but first check
on Rubygems if they support puppet-lint 2.x.

A number of tasks are defined by the `Rakefile`:

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

Contributions are always very welcome. Any change however should be motivated
with a good explanation of why this change is necessary and generally have
commits that:

* Are written in the imperative style
* Where a single commit represents a single feature
* Have a short subject
* Include as much text as needed in the body to motivate this change
