module ASAP
  module ADT
    module GIS
      
      class GeographicRectangle < GeographicPointContainer
        define_accessors :corners   => {:type      => Array,
                                        :required  => true,
                                        :validator => lambda {|value| value.size == 2 && value.all? {|vertex| vertex.kind_of? GeographicPoint}}}
      
        def initialize(ne_longitude_value, ne_longitude_hemisphere, ne_latitude_value, ne_latitude_hemisphere, sw_longitude_value, sw_longitude_hemisphere, sw_latitude_value, sw_latitude_hemisphere, initializers={})
          initializers = {:corners => [GeographicPoint.new(:longitude => Longitude.new(:value => ne_longitude_value.to_f.abs, :hemisphere => ne_longitude_hemisphere.to_sym),
                                                           :latitude  => Latitude.new( :value => ne_latitude_value.to_f.abs,  :hemisphere => ne_latitude_hemisphere.to_sym)),
                                       GeographicPoint.new(:longitude => Longitude.new(:value => sw_longitude_value.to_f.abs, :hemisphere => sw_longitude_hemisphere.to_sym),
                                                           :latitude  => Latitude.new( :value => sw_latitude_value.to_f.abs,  :hemisphere => sw_latitude_hemisphere.to_sym))]}
          super initializers
        end
        
        def to_s
          corners.join "; "
        end
        
        def ne_corner
          @corners = Array.new(2) unless corners
          corners[0]
        end
        
        def ne_corner=(value)
          @corners = Array.new(2) unless corners
          corners[0] = value
        end
        
        def ne_longitude_value
          (ne_corner && ne_corner.longitude) ? ne_corner.longitude.value : nil
        end
        
        def ne_longitude_value=(value)
          ne_corner ||= GeographicPoint.new
          ne_corner.longitude ||= Longitude.new 
          ne_corner.longitude.value = value
        end
        
        def ne_longitude_hemisphere
          (ne_corner && ne_corner.longitude) ? ne_corner.longitude.hemisphere.to_sym : nil
        end
        
        def ne_longitude_hemisphere=(hemisphere)
          ne_corner ||= GeographicPoint.new
          ne_corner.longitude ||= Longitude.new
          ne_corner.longitude.hemisphere = hemisphere.to_sym
        end
        
        def ne_latitude_value
          (ne_corner && ne_corner.latitude)  ? ne_corner.latitude.value  : nil
        end
        
        def ne_latitude_value=(value)
          ne_corner ||= GeographicPoint.new
          ne_corner.latitude ||= Latitude.new
          ne_corner.latitude.value = value
        end
        
        def ne_latitude_hemisphere
          (ne_corner && ne_corner.latitude) ? ne_corner.latitude.hemisphere.to_sym : nil
        end
        
        def ne_latitude_hemisphere=(hemisphere)
          ne_corner ||= GeographicPoint.new
          ne_corner.latitude ||= Latitude.new
          ne_corner.latitude.hemisphere = hemisphere.to_sym
        end
        
        def sw_corner
          @corners = Array.new(2) unless corners
          corners[1]
        end
        
        def sw_corner=(value)
          @corners = Array.new(2) unless corners
          corners[1] = value
        end
        
        def sw_longitude_value
          (sw_corner && sw_corner.longitude) ? sw_corner.longitude.value : nil
        end
        
        def sw_longitude_value=(value)
          sw_corner ||= GeographicPoint.new
          sw_corner.longitude ||= Longitude.new
          sw_corner.longitude.value = value
        end
        
        def sw_longitude_hemisphere
          (sw_corner && sw_corner.longitude) ? sw_corner.longitude.hemisphere.to_sym : nil
        end
        
        def sw_longitude_hemisphere=(hemisphere)
          sw_corner ||= GeographicPoint.new
          sw_corner.longitude ||= Longitude.new
          sw_corner.longitude.hemisphere = hemisphere.to_sym
        end
        
        def sw_latitude_value
          (sw_corner && sw_corner.latitude)  ? sw_corner.latitude.value  : nil
        end
        
        def sw_latitude_value=(value)
          sw_corner ||= GeographicPoint.new
          sw_corner.latitude ||= Latitude.new
          sw_corner.latitude.value = value
        end
        
        def sw_latitude_hemisphere
          (sw_corner && sw_corner.latitude) ? sw_corner.latitude.hemisphere.to_sym : nil
        end
        
        def sw_latitude_hemisphere=(hemisphere)
          sw_corner ||= GeographicPoint.new
          sw_corner.latitude ||= Latitude.new
          sw_corner.latitude.hemisphere = hemisphere.to_sym
        end
        
        def area(unit)  # TODO: Rewrite, accounting for units of measure and for curved surfaces (such as the Earth's!)
          Area.new(((corners[1].longitude.signed_value - corners[0].longitude.signed_value) *
                    (corners[1].latitude.signed_value  - corners[0].latitude.signed_value)).abs,
                   unit)
        end
      end

    end
  end
end