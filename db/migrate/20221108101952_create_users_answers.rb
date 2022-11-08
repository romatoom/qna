class CreateUsersAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :users_answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
