require "rake/testtask"

Rake::TestTask.new do |t|
  ENV['DATABASE_ENV'] = 'test'
  t.test_files = FileList['test/**/test_*.rb']
  t.warning = false
end
desc "Run tests"

task default: :test
