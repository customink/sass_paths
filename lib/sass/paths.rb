require "sass/paths/gem"
require "sass/paths/version"
if defined?(Rails)
  require 'sass/paths/engine'
end

module Sass
  module Paths
    class << self
      include Gem

      def append(*paths)
        new_paths = [env_path.split(File::PATH_SEPARATOR), paths].flatten
                                                                 .compact
                                                                 .uniq
        ENV["SASS_PATH"] = new_paths.join(File::PATH_SEPARATOR)
      end

      def append_gem_path(gem, path)
        append(gem_sass_path(gem, path))
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
end
