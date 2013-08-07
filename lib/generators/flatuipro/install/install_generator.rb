require 'rails/generators'
require 'pathname'

module Flatuipro
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Copies licensed Flat UI Pro files to designmodo-flatuipro-rails gem."
      argument :flatuipro_dir, :type => :string, :banner => "<Licensed Flat UI Pro directory>"
      source_root File.expand_path("../templates", __FILE__)

      def copy_assets
        gem_assets_dir = File.expand_path("../../../../../app/assets", __FILE__)
        pro_dir = flatuipro_dir

        unless File.exist?(File.join(pro_dir, "index.html"))
          pro_dir = File.join(pro_dir, "HTML/UI")
        end
        unless File.directory?(pro_dir) && File.exist?(File.join(pro_dir, "index.html"))
          raise "Invalid Flat UI Pro directory"
        end

        if use_less?
          directory File.join(pro_dir, "less"), File.join(gem_assets_dir, "less")
        else
          copy_file File.join(pro_dir, "css", "flat-ui.css"), "app/assets/stylesheets/flat-ui.css"
        end
        directory File.join(pro_dir, "js"),                   File.join(gem_assets_dir, "javascripts")
        directory File.join(pro_dir, "images"),               File.join(gem_assets_dir, "images")
        directory File.join(pro_dir, "fonts"),                File.join(gem_assets_dir, "fonts")

        # Demo page assets
        copy_file File.join(pro_dir, "index.html"),           File.join(gem_assets_dir, "demo", "index.html")
        copy_file File.join(pro_dir, "js", "application.js"), File.join(gem_assets_dir, "demo", "flatuipro-demo.js")
        copy_file File.join(pro_dir, "css", "demo.css"),      File.join(gem_assets_dir, "demo", "flatuipro-demo.css")
        copy_file File.join(pro_dir, "less", "demo.less"),    File.join(gem_assets_dir, "demo", "flatuipro-demo.less")
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
          unless content.match(/require\s+jquery.ui.all/)
            unless content.match(/require\s+jquery.ui.effect/)
              insert_into_file js_manifest, "//= require jquery.ui.effect\n", :after => "jquery\n"
            end
            unless content.match(/require\s+jquery.ui.tooltip/)
              insert_into_file js_manifest, "//= require jquery.ui.tooltip\n", :after => "jquery\n"
            end
            unless content.match(/require\s+jquery.ui.spinner/)
              insert_into_file js_manifest, "//= require jquery.ui.spinner\n", :after => "jquery\n"
            end
            unless content.match(/require\s+jquery.ui.slider/)
              insert_into_file js_manifest, "//= require jquery.ui.slider\n", :after => "jquery\n"
            end
            unless content.match(/require\s+jquery.ui.datepicker/)
              insert_into_file js_manifest, "//= require jquery.ui.datepicker\n", :after => "jquery\n"
            end
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
        gem_assets_dir = File.expand_path("../../../../../app/assets", __FILE__)

        # Stylesheets patches
        # image url() -> image-url()
        # font  url() -> font-url()
        # LESS
        if use_less?
          # switch.less
          # More involved patch because less-rails won't translate when inside ~""
          # Create LESS variable and interpolate into .mask(~"")
          switch_file = File.join(gem_assets_dir, "less/modules", "switch.less")
          mask_image_url = "@mask-image-url: image-url('switch/mask.png');\n"
          insert_into_file switch_file, mask_image_url, :before => ".has-switch {\n"
          gsub_file switch_file, /url\('\.\.\/images\/.+?\)/, "@{mask-image-url}"

          # icon-font.less
          gsub_file File.join(gem_assets_dir, "less", "icon-font.less"), /url\("\.\.\/fonts\//, 'font-url("'
        # CSS
        else
          gsub_file "app/assets/stylesheets/flat-ui.css", /url\('\.\.\/images\//, "url('/assets/"
          gsub_file "app/assets/stylesheets/flat-ui.css", /url\("\.\.\/fonts\//, 'url("/assets/'
        end

        # Demo page patches
        file = File.join(gem_assets_dir, "demo", "index.html")
        # Fix image links
        gsub_file file, /<img src="images\/.+?>/ do |s|
          match = /images\/(.+?)"/.match(s)
          '<%= image_tag "' + match[1] + '" %>'
        end

        # Remove everything before <body> tag and after 'Load JS', inclusive
        new_file = File.open("#{file}.erb", "w")
        include_line = false
        IO.foreach(file) do |line|
          include_line = false if line =~ /Load JS/

          new_file.write line if include_line

          include_line = true if line =~ /<body>/
        end
        new_file.close
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