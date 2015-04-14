class AddAttributeToBooks < ActiveRecord::Migration
  def change
    change_column :books, :availability, :boolean, default: true
  end
end
