# загружаем библиотечные классы
lambda do
  lib_path  = '%s/**/*.rb' % File.expand_path('../mealib', __FILE__)
  # noinspection RubyResolve
  Dir[lib_path].each { |f| require_relative f }

  require_relative 'dry/errors'
  require_relative 'dry/schema'
  require_relative 'dry/rule'

  require_relative 'dry/rules/binary'
  require_relative 'dry/rules/composite'
  require_relative 'dry/rules/between'
  require_relative 'dry/rules/min_length'
  require_relative 'dry/rules/greater_than'
  require_relative 'dry/rules/not_equal'
  require_relative 'dry/rules/less_than'
  require_relative 'dry/rules/greater_than_or_equal'
  require_relative 'dry/rules/collection'
  require_relative 'dry/rules/length_between'
  require_relative 'dry/rules/or'
  require_relative 'dry/rules/and'
  require_relative 'dry/rules/less_than_or_equal'
  require_relative 'dry/rules/then'
  require_relative 'dry/rules/format'
  require_relative 'dry/rules/present'
  require_relative 'dry/rules/length_equal'
  require_relative 'dry/rules/included'
  require_relative 'dry/rules/equal'
  require_relative 'dry/rules/max_length'

  require_relative 'dry/rules_factory'
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
