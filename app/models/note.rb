class Note < ActiveRecord::Base
  validates :topic, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { maximum: 500 }
  belongs_to :user
  belongs_to :course

  def initialize(params={})
    file = params.delete(:file)
    super
    if file
      self.filename = sanitize_filename(file.original_filename)
      self.content_type = file.content_type
      self.file_contents = file.read
    end
  end

  private
    def sanitize_filename(filename)
      return File.basename(filename)
    end
end
