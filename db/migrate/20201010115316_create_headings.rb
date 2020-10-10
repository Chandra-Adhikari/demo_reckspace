class CreateHeadings < ActiveRecord::Migration[6.0]
  def change
    create_table :headings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
