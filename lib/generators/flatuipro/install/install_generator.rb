require 'rails/generators'

module Flatuipro
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copies licensed Flat UI Pro files to designmodo-flatuipro-rails gem."
      argument :flatuipro_dir, :type => :string, :banner => "<Licensed Flat UI Pro directory>"

      def copy_assets
        InstallGenerator.source_root flatuipro_dir
        assets_dir = File.expand_path("../../../../../vendor/assets", __FILE__)
        directory "HTML/UI/less",   File.join(assets_dir, "stylesheets"), :verbose => true
        directory "HTML/UI/js",     File.join(assets_dir, "javascripts"), :verbose => true
        directory "HTML/UI/images", File.join(assets_dir, "images"), :verbose => true
        directory "HTML/UI/fonts",  "public/fonts", :verbose => true
      end
    end
  end
end