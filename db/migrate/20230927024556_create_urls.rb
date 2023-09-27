class CreateUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :urls do |t|
      t.string :original, null: false, unique: true
      t.string :short, null: false, index: { unique: true }
      t.timestamps
    end
  end
end
