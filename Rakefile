require 'pathname'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

# This is needed until https://github.com/rodjek/puppet-lint/commit/efb19675 gets released
# Need to add the bootstrap/ directory to the exclude paths
Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.pattern = 'dist/**/*.pp'
  config.disable_checks = ['documentation', '140chars']
  config.with_filename = true
  config.fail_on_warnings = true
  config.log_format = '%{filename} - %{message}'
  config.with_context = true
  config.fix = false
  config.show_ignored = false
  config.relative = true
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
