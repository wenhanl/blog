class UploaderController < ApplicationController
  def index

  end

  def upload
    # upload selected file to server
    file = params[:upload]
    filename = file.original_filename
    basepath = Rails.root.join('public', 'uploads')
    upload_file = basepath.join(filename)
    if File.exist?(upload_file.to_s)
      index = filename.index('.')
      filename.insert(index, '_1')
    end
    File.open(basepath.join(filename), 'wb') do |f|
      f.write(file.read)
    end

    # change image_list to new uploaded file name
    listname = basepath.join('image_list.json')

    content = '[{"image": "/uploads/' + filename + '"}]'

    File.open(listname, 'w') { |f| f.puts content }

    render :text => content

  end
end
