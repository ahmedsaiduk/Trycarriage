# transactions migration with sheet
class CreateTransactions < ActiveRecord::Migration[5.1]
  require 'csv'
  def change
    create_table :transactions do |t|
      t.string :street
      t.string :city
      t.integer :zip
      t.string :state
      t.integer :beds
      t.string :baths
      t.decimal :sq_ft
      t.string :types
      t.timestamp :sale_date
      t.decimal :price
      t.decimal :latitude
      t.decimal :longitude
      t.timestamps
    end
    # import file once the migration made
    CSV.read('public/Sacramentorealestatetransactions.csv').drop(1).each do |row|
      transaction = Transaction.create(street: row[0].to_s, city: row[1].to_s, zip: row[2].to_i, state: row[3].to_s, beds: row[4].to_i,
                                       baths: row[5].to_i, sq_ft: row[6].to_f, types: row[7], sale_date: Time.parse(row[8]),
                                       price: row[9].to_f, latitude: row[10].to_f, longitude: row[11].to_f)
    end
  end
end
