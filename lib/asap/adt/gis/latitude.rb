module ASAP
  module ADT
    module GIS
          
      class Latitude < GeographicCoordinate
        define_accessors :hemisphere => {:type      => Symbol,
                                         :required  => true,
                                         :validator => lambda {|value| [:north, :south].include? value}}
        define_derivers  :signed_value => {:deriver => lambda {hemisphere == :south ? -value : value}}
        
        def to_s
          text = super
          case hemisphere
            when :north
              #text << 'N'
            when :south
              text.insert(0, '-') # text << 'S'
          end
          text
        end
        
        def as_precision
          lat = super 
          hemisphere == :north ? lat : -lat
        end
      end

    end
  end
end