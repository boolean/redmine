class RanameTableQueriesToCustomQueries < ActiveRecord::Migration
  def self.up
    rename_table :queries, :custom_queries
  end

  def self.down
    rename_table :custom_queries, :queries
  end
end
