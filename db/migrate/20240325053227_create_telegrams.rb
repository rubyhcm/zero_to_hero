class CreateTelegrams < ActiveRecord::Migration[7.1]
  def change
    create_table :telegrams do |t|

      t.timestamps
    end
  end
end
