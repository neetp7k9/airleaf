module V1
  class Notes < Grape::API
    resource :notes do
      desc "download the file by id"

      params do
        requires :id, type: Integer
      end

      get '/download' do
        file = Note.find_by(id: params[:id])
        filename = file.filename
        content_type file.content_type
        env['api.format'] = :binary
        header 'Content-Disposition',
               "attachment; filename*=UTF-8''#{URI.escape(filename)}"
        file.file_contents
      end

      desc "create a new note"

      params do
        requires :course_name, type: String
        requires :topic, type: String
        requires :description, type: String
        requires :file, type: File
      end

      post do
        course = Course.find_by(name: params[:course_name])

        filename = params[:file][:filename]
        content_type MIME::Types.type_for(filename)[0].to_s
        env['api.format'] = :binary
        header 'Content-Disposition', "attachment; filename*=UTF-8''#{URI.escape(filename)}"

        note = Note.new
        note.topic = params[:topic]
        note.description = params[:description]
        note.filename = filename
        note.content_type = MIME::Types.type_for(filename)[0].to_s
        note.file_contents = params[:file][:tempfile].read

        if course
          # put the note under the course
          note.course_id = course.id
        else
          # create the course
          new_course = Course.create(name: params[:course_name])
          note.course_id = new_course.id
        end

        note.save!
      end

      desc "delete a note"

      params do
        requires :id, type: Integer
      end

      delete do
        note = Note.find_by(id: params[:id])
        filename =  note.filename
        content_type MIME::Types.type_for(filename)[0].to_s
        env['api.format'] = :binary
        header 'Content-Disposition', "attachment; filename*=UTF-8''#{URI.escape(filename)}"
        note.destroy!
      end

      desc "edit the note"
      params do
        requires :id, type: Integer
        optional :topic, default: nil, type: String
        optional :description, default: nil, type: String
        optional :file, default: nil, type: File
      end

      patch do
        note = Note.find_by(id: params[:id])
        if params[:topic]
          note.topic = params[:topic]
        end
        if params[:description]
          note.description = params[:description]
        end
        if params[:file]
          filename = params[:file][:filename]
          content_type MIME::Types.type_for(filename)[0].to_s
          env['api.format'] = :binary
          header 'Content-Disposition', "attachment; filename*=UTF-8''#{URI.escape(filename)}"
          note.filename = filename
          note.content_type = MIME::Types.type_for(filename)[0].to_s
          note.file_contents = params[:file][:tempfile].read
        end
        note.save!
      end

    end
  end
end
