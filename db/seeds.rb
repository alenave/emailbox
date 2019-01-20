SEED_TABLE_NAMES = %w[
  users tags
].freeze

def csv_path(file_name)
  "db/csvs/#{file_name}.csv"
end

def sync!
  SEED_TABLE_NAMES.each do |table_name|
    klass = Object.const_set(table_name.classify, Class.new(ActiveRecord::Base))
    sync_table!(klass, table_name)
  end
end

def sync_table!(klass, file_name)
  puts "Seeding #{file_name}"
  klass.transaction do
    CSV.foreach(csv_path(file_name), headers: true).each do |record|
      klass.where(record.to_hash).first_or_create
    end
  end
end

sync!
