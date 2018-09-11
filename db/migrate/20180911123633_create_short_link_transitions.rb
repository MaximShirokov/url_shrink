class CreateShortLinkTransitions < ActiveRecord::Migration[5.0]
  def change
    create_table :short_link_transitions do |t|
      t.string :device
      t.string :browser
      t.references :short_link, foreign_key: true

      t.timestamps
    end
  end
end
