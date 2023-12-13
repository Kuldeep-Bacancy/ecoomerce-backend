class CreateBlacklistTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :blacklist_tokens do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
