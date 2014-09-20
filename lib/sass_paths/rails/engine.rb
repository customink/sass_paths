module SassPaths
  class Engine < ::Rails::Engine
    config.after_initialize do
      ::SassPaths.reload_paths!
    end
  end
end
