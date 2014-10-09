require "sass_paths/gem"
require "sass_paths/bower"
require "sass_paths/version"
require 'sass'

module SassPaths
  class << self
    include Gem
    include Bower

    def append(*paths)
      existing_paths = paths.select { |path| Dir.exists? path }
      new_paths = [env_path.split(File::PATH_SEPARATOR), existing_paths].flatten
                                                                        .compact
                                                                        .uniq
      ENV["SASS_PATH"] = new_paths.join(File::PATH_SEPARATOR)
    end

    def append_gem_path(gem, path)
      append(gem_sass_path(gem, path))
    end

    def append_bower_components(relative_bower_path)
      sass_paths = get_bower_sass_paths(relative_bower_path)
      append(*sass_paths)
    end

    def env_path
      ENV["SASS_PATH"] || ""
    end

    def reload_paths!
      append(*Sass.load_paths)
      Sass.instance_variable_set('@load_paths', nil)
      Sass.load_paths
    end
  end
end

if defined?(Rails)
  require 'sass_paths/rails/engine'
end
