require 'pathname'
require 'puppetlabs_spec_helper/rake_tasks'

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
