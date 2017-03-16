require 'sass_paths/gem'
require 'sass_paths/version'
require 'sass'

module SassPaths
  class << self
    include Gem

    def append(*paths)
      existing_paths = paths.select { |path| Dir.exist? path }
      new_paths = [
        env_path.split(File::PATH_SEPARATOR),
        existing_paths
      ].flatten.compact.uniq
      self.env_path = new_paths
    end

    def append_gem_path(gem, path)
      append(gem_sass_path(gem, path))
    end

    def env_path
      ENV['SASS_PATH'] || ''
    end

    def env_path=(*paths)
      ENV['SASS_PATH'] = paths.join(File::PATH_SEPARATOR)
    end

    def reload_paths!
      append(*Sass.load_paths)
      Sass.instance_variable_set('@load_paths', nil)
      Sass.load_paths
    end

    def with_replacements(replacements = {})
      reload_paths!
      old_paths = Sass.load_paths.dup
      tmp_paths = old_paths.map do |path|
        replacements[path] ? replacements[path] : path
      end
      self.env_path = tmp_paths
      reload_paths!
      yield
    ensure
      self.env_path = old_paths
      reload_paths!
    end
  end
end

require 'sass_paths/rails/engine' if defined?(Rails)
