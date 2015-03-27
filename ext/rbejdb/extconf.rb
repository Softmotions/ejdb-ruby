require "mkmf"

unless have_library('ejdb')
  raise "EJDB C library is not installed!"
end

$CFLAGS << ' -Wall'
CONFIG['warnflags'].gsub!('-Wdeclaration-after-statement', '')
create_makefile("rbejdb", ARGV[0] || 'src')
