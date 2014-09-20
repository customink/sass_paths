module Sass
  module Paths
    module Gem
      private

      def gem_sass_path(gem, directory)
        require gem
        File.join(gem_path(gem), directory)
      end

      def gem_path(gem)
        ::Gem::Specification.find_all_by_name(gem).first.full_gem_path
      end
    end
  end
end
