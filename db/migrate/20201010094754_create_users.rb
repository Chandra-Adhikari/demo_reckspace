class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :website_url
      t.string :shortened_url

      t.timestamps
    end
  end
end
