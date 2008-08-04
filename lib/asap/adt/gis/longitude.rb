module ASAP
  module ADT
    module GIS
          
      class Longitude < GeographicCoordinate
        define_accessors :hemisphere => {:type      => Symbol,
                                         :required  => true,
                                         :validator => lambda {|value| [:east, :west].include? value}}
        define_derivers  :signed_value => {:deriver => lambda {hemisphere == :west ? -value : value}}
        
        def to_s
          text = super
          case hemisphere
            when :east
              #text << 'E'
            when :west
              text.insert(0, '-')  #text << 'W'
          end
          text
        end
        
        def as_precision
          lng = super 
          hemisphere == :east ? lng : -lng
        end
      end

    end
  end
end