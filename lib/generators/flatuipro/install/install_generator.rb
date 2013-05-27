require 'rails/generators'
require 'pathname'

module Flatuipro
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copies licensed Flat UI Pro files to designmodo-flatuipro-rails gem."
      argument :flatuipro_dir, :type => :string, :banner => "<Licensed Flat UI Pro directory>"
      source_root File.expand_path("../templates", __FILE__)

      def copy_assets
        if Pathname.new(flatuipro_dir).basename != "UI"
          new_flatuipro_dir = File.join(flatuipro_dir, "HTML/UI")
          if File.directory?(new_flatuipro_dir)
            flatuipro_dir = new_flatuipro_dir
          else
            raise "Invalid Flat UI Pro directory"
          end
        end
        gem_assets_dir = File.expand_path("../../../../../vendor/assets", __FILE__)

        if use_less?
          directory File.join(flatuipro_dir, "less"), File.join(gem_assets_dir, "less")
        else
          copy_file File.join(flatuipro_dir, "css", "flat-ui.css"), "app/assets/stylesheets/flat-ui.css"
        end
        directory File.join(flatuipro_dir, "js"),     File.join(gem_assets_dir, "javascripts")
        directory File.join(flatuipro_dir, "images"), File.join(gem_assets_dir, "images")
        directory File.join(flatuipro_dir, "fonts"),  File.join(gem_assets_dir, "fonts")
      end

      def add_assets
        copy_file "flatuipro.js",   "app/assets/javascripts/flatuipro.js"
        if use_less?
          copy_file "flatuipro.less", "app/assets/stylesheets/flatuipro.less"
        end

        # Handle JS Manifest
        js_manifest = "app/assets/javascripts/application.js"
        if File.exist?(js_manifest)
          content = File.read(js_manifest)
          unless content.match(/require\s+flatuipro/)
            insert_into_file js_manifest, "//= require flatuipro\n", :after => "twitter/bootstrap\n"
          end
        else
          copy_file "application.js", js_manifest
        end

        # Handle CSS Manifest
        css_manifest = "app/assets/stylesheets/application.css"
        if File.exist?(css_manifest)
          content = File.read(css_manifest)
          unless content.match(/require_tree\s+\./)
            style_require_block = " *= require flatuipro\n"
            insert_into_file css_manifest, style_require_block, :after => "require_self\n"
          end
        else
          copy_file "application.css", "app/assets/stylesheets/application.css"
        end
      end

      def patch_assets
        gem_assets_dir = File.expand_path("../../../../../vendor/assets", __FILE__)

        # Stylesheets patches
        # image url() -> image-url()
        # font  url() -> font-url()
        # LESS
        if use_less?
          gsub_file File.join(gem_assets_dir, "less/modules", "switch.less"), /url\('\.\.\/images\//, "image-url('"
          gsub_file File.join(gem_assets_dir, "less", "icon-font.less"), /url\("\.\.\/fonts\//, 'font-url("'
        # CSS
        else
          gsub_file "app/assets/stylesheets/flat-ui.css", /url\('\.\.\/images\//, "image-url('"
          gsub_file "app/assets/stylesheets/flat-ui.css", /url\("\.\.\/fonts\//, 'font-url("'
        end

      end

      private
        # Detect if twitter-bootstrap-rails installed with LESS or static stylesheets
        def use_less?
          if File.exist?("app/assets/stylesheets/bootstrap_and_overrides.css.less")
            return true
          elsif File.exist?("app/assets/stylesheets/bootstrap_and_overrides.css")
            return false
          else
            raise "Cannot detect twitter-bootstrap-rails install"
          end
        end
    end
  end
end