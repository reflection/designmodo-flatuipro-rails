require 'rails/generators'
require 'pathname'

module Flatuipro
  module Generators
    class DemoGenerator < Rails::Generators::Base
      desc "Setup Flat UI Pro Demo page."
      source_root File.expand_path("../../../../../app/assets/demo", __FILE__)

      # Detect if Flat UI Pro assets copied over to gem
      def check_flatuipro_install
        unless File.exist?(File.expand_path("../../../../../app/assets", __FILE__))
          raise "Please run install generator first"
        end
      end

      def generate_demo_controller
        generate "controller flatuipro_demo index --no-helper --no-test-framework --no-assets"
      end

      def add_demo_assets
        # Overwrite generated index.html.erb with demo html
        copy_file "index.html.erb", "app/views/flatuipro_demo/index.html.erb"

        # Add demo less/css
        if use_less?
          copy_file "flatuipro-demo.less", "app/assets/stylesheets/flatuipro-demo.less"
        else
          copy_file "flatuipro-demo.css", "app/assets/stylesheets/flatuipro-demo.css"
        end

        # Handle CSS Manifest
        css_manifest = "app/assets/stylesheets/application.css"
        if File.exist?(css_manifest)
          content = File.read(css_manifest)
          unless content.match(/require_tree\s+\./)
            style_require_block = " *= require flatuipro-demo\n"
            insert_into_file css_manifest, style_require_block, :after => "require_self\n"
          end
        end

        # Add demo javascript
        copy_file "flatuipro-demo.js", "app/assets/javascripts/flatuipro-demo.js"

        # Handle JS Manifest
        js_manifest = "app/assets/javascripts/application.js"
        if File.exist?(js_manifest)
          content = File.read(js_manifest)
          unless content.match(/require_tree\s+\./)
            insert_into_file js_manifest, "//= require flatuipro-demo\n", :after => "flatuipro\n"
          end
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