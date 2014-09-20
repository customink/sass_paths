module Sass
  module Paths
    class Engine < ::Rails::Engine
      config.after_initialize do
        ::Sass::Paths.reload_paths!
      end
    end
  end
end
