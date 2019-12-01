class CreateTrainings < ActiveRecord::Migration[5.1]
  def change
    create_table :trainings do |t|

      t.timestamps
    end
  end
end
