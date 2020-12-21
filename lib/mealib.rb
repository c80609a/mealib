# загружаем библиотечные классы
lambda do
  lib_path  = '%s/**/*.rb' % File.expand_path('../mealib', __FILE__)
  # noinspection RubyResolve
  Dir[lib_path].each { |f| require_relative f }
end.call

# загружаем все классы из директории app
lambda do
  lib_path  = File.expand_path('../../app', __FILE__)
  dir_names = %w[] # order matters!

  dir_names.each do |dir|
    dir_path = '%s/%s/**/*.rb' % [lib_path, dir]
    # noinspection RubyResolve
    Dir[dir_path].each { |f| require_relative f }
  end
end.call

module Mealib
end
