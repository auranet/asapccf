module ASAP
  module ADT
    module GIS
          
      class Longitude < GeographicCoordinate
        define_accessors :hemisphere => {:type      => Symbol,
                                         :required  => true,
                                         :validator => lambda {|value| [:east, :west].include? value}}
        define_derivers  :signed_value => {:deriver => lambda {hemisphere == :west ? -value : value}}
        
        def to_s
          text = ''
          case hemisphere
            when :east
              #text << 'E'
            when :west
              text << '-'
          end
          text << super
          text
        end
      end

    end
  end
end