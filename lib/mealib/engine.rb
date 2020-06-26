module Mealib
  class Engine < ::Rails::Engine
    config.i18n.load_path += Dir[config.root.join('config', 'locales', '**','*.{yml}').to_s]
  end
end