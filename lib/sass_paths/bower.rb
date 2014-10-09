require 'json'

module SassPaths
  module Bower

    private

    PERMITTED_FILE_EXTENSIONS = ['.scss', '.sass'].freeze

    def get_bower_sass_paths(bower_path)
      sass_paths = []
      Dir["#{bower_path}/**/.bower.json"].each do |f|
        get_main_paths(f).each do |path|
          sass_paths << path
        end
      end
      sass_paths
    end

    def get_main_paths(file_name)
      base_directory = File.dirname(file_name)
      bower_json = JSON.parse(File.read(file_name))

      main_files = wrap_in_array(bower_json['main'])
        .select { |main_file| PERMITTED_FILE_EXTENSIONS.include? File.extname(main_file) }
        .map { |main_file| "#{base_directory}/#{File.dirname(main_file)}" }
    end

    def wrap_in_array(object)
      if object.nil?
        []
      elsif object.respond_to?(:to_ary)
        object.to_ary || [object]
      else
        [object]
      end
    end
  end
end
