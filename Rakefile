require 'pathname'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

# This is needed until https://github.com/rodjek/puppet-lint/commit/efb19675 gets released
# Need to add the bootstrap/ directory to the exclude paths
Rake::Task[:lint].clear
PuppetLint.configuration.relative = true
PuppetLint::RakeTask.new(:lint) do |config|
  config.fail_on_warnings = true
  config.disable_checks = [
      '80chars',
      'class_inherits_from_params_class',
      'class_parameter_defaults',
      'documentation',
      'single_quote_string_with_variables']
  config.ignore_paths = ["bootstrap/**/*.pp", "tests/**/*.pp", "vendor/**/*.pp","examples/**/*.pp", "spec/**/*.pp", "pkg/**/*.pp"]
end

task(:lint_output) { puts '---> lint'}
Rake::Task[:lint].enhance [:lint_output]

desc "Run specs for every module in dist/"
task :dist_spec do
  dirs = Pathname.new('dist').children.select { |c| c.directory? }
  dirs.each do |mod|
    Dir.chdir(mod) do
      if File.directory?('spec')
        puts "---> spec: #{mod}"
        system "rake spec"
      end
    end
  end
end

desc "Run syntax, lint and spec tests"
task :test => [
  :syntax,
  :lint,
  :dist_spec,
]
