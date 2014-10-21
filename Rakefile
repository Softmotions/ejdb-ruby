# encoding: utf-8

require 'rubygems' unless defined?(Gem)
require 'rake' unless defined?(Rake)

require 'rake/extensiontask'
require 'rake/testtask'

Rake::ExtensionTask.new('rbejdb') do |ext|
  ext.lib_dir = "lib/ejdb"
end

desc 'Run RBEJDB tests'
Rake::TestTask.new(:test) do |t|
  t.test_files = Dir.glob("test/test_*.rb")
  t.verbose = true
  t.warning = true
end

task :test => :compile
task :default => :test