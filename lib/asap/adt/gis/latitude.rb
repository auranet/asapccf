module ASAP
  module ADT
    module GIS
          
      class Latitude < GeographicCoordinate
        define_accessors :hemisphere => {:type      => Symbol,
                                         :required  => true,
                                         :validator => lambda {|value| [:north, :south].include? value}}
        define_derivers  :signed_value => {:deriver => lambda {hemisphere == :south ? -value : value}}
        
        def to_s
          text = ''
          case hemisphere
            when :north
              #text << 'N'
            when :south
              text << '-'
          end
          text << super
          text
        end
      end

    end
  end
end