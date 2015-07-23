require 'puppetlabs_spec_helper/rake_tasks'

task(:syntax_output) { puts '---> lint'}
task(:spec_output) { puts '---> spec'}

Rake::Task[:lint].enhance [:syntax_output]
Rake::Task[:spec].enhance [:spec_output]

desc "Run syntax, lint and spec tests"
task :test => [
  :syntax,
  :lint,
  :spec,
]
