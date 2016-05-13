class AddDetailsToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :filename, :string
    add_column :notes, :content_type, :string
    add_column :notes, :file_contents, :binary
  end
end
