class CreateShortLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :short_links do |t|
      t.string :original_link, null: false
      t.string :short_code, null: false

      t.datetime :start_at
      t.datetime :expire_at
      t.timestamps :null => false

      t.references :user, foreign_key: true
    end
  end
end
