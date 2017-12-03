# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

desc 'Run tests'
Rake::TestTask.new do |t|
  ENV['DATABASE_ENV'] = 'test'
  t.test_files = FileList['test/**/test_*.rb']
  t.warning = false
end

desc 'Lint'
RuboCop::RakeTask.new(:lint, 'bin', 'config', 'db/migrations', 'lib', 'test', '*.rb')

task default: :test
