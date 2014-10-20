require "rbejdb"
require "test/unit"

TESTDB_DIR = 'testdb'

unless File.exist?(TESTDB_DIR)
  Dir.mkdir TESTDB_DIR
end