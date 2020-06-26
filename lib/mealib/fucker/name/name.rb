module Fucker
  module Name
    def make_first_name(lang: :ru, sex: :man)
      _fuck 'first_name_%s_%s' % [lang, sex]
    end

    def make_last_name(lang: :ru, sex: :man)
      _fuck 'last_name_%s_%s' % [lang, sex]
    end

    def make_sur_name(lang: :ru, sex: :man)
      _fuck 'sur_name_%s_%s' % [lang, sex]
    end

    #noinspection RubyNilAnalysis
    def _fuck(filename)
      file        = File.expand_path('%s.txt' % filename, File.dirname(__FILE__))
      chosen_line = nil

      File.foreach(file).each_with_index do |line, number|
        chosen_line = line if rand < 1.0/(number+1)
      end

      chosen_line.split("\n").join
    end
  end
end
