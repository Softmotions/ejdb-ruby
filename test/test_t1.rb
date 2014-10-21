require File.join(File.dirname(__FILE__), 'helper')

class Parrot
  def initialize(name, size)
    @name = name
    @size = size
  end
end

class EJDBTestBatchOne < Test::Unit::TestCase

  def test_save_and_find
    ejdb = EJDB.open(File.join(TESTDB_DIR, "zoo"), EJDB::DEFAULT_OPEN_MODE)

    raise "Failed to open ejdb" unless ejdb.open?

    ejdb.drop_collection("parrots", true)
    ejdb.drop_collection("cows", true)

    ejdb.ensure_collection("parrots")
    ejdb.ensure_collection("parrots", {"large" => true, "records" => 200000})

    parrot1 = Parrot.new("Cacadoo", 12)
    ejdb.save("parrots", parrot1)

    parrot2 = {:name => "Mamadoo", :size => 666, "likes" => ["green color", "night", ["toys", "joys"], parrot1]}
    ejdb.save("parrots", parrot2)

    ejdb.save("cows", :name => "moo")


    ejdb.find("parrots", {:name => "Cacadoo"}).each { |res|
      puts res.inspect
    }

    ejdb.find("parrots", {:name => {"$in" => %w(Mamadoo Sauron)}}).each { |res|
      puts res.inspect
    }

    puts ejdb.find("cows", {}).to_a.inspect

    raise "Error querying cows"  unless ejdb.find("cows", :name => "moo").any? {|res| res["name"] == 'moo'}

    ejdb.close

    raise "Failed to close ejdb" unless !ejdb.open?

    puts "CONGRATULATIONS!!! Test batch 1 has passed completely!"
  end
end
