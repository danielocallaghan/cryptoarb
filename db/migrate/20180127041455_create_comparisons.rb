class CreateComparisons < ActiveRecord::Migration[5.1]
  def change
    create_table :comparisons do |t|

      t.timestamps
    end
  end
end
