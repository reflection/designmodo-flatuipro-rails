require "designmodo/flatuipro/rails/version"

module Designmodo
  module Flatuipro
    module Rails
      class Engine < ::Rails::Engine
        initializer 'designmodo-flatuipro-rails.setup',
          :after => 'less-rails.after.load_config_initializers',
          :group => :all do |app|
            if defined?(Less)
              app.config.less.paths << File.join(config.root, 'app', 'less')
            end
          end
      end
    end
  end
end
