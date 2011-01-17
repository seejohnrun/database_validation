ActiveRecord::Schema.define(:version => 0) do
  create_table :users do |t|
    t.string :username, :limit => 20, :null => false
    t.string :password, :null => false
  end

  add_index :users, :username, :unique => true

  create_table :people do |t|
    t.string :fullname, :limit => 100, :null => false
    t.string :address
    t.integer :user_id
  end
end
