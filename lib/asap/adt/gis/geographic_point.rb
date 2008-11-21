module ASAP
  module ADT
    module GIS
          
      class GeographicPoint < GeographicObject
        define_accessors :latitude  => {:type      => Latitude,
                                        :required  => true,
                                        :converter => lambda {|value| Latitude.new(:value => value.abs, :hemisphere => (value >= 0 ? :north : :south))}},
                         :longitude => {:type      => Longitude,
                                        :required  => true,
                                        :converter => lambda {|value| Longitude.new(:value => value.abs, :hemisphere => (value >= 0 ? :east : :west))}},
                         :elevation => {:type      => Elevation,
                                        :converter => lambda {|value| Elevation.new(:value => value)}},
                         :type      => {:type      => Symbol,
                                        :default   => :O,
                                        :validator => lambda {|value| [:C, :I, :E, :O, :P ].include?(value) }},
                         :seq      => {:type      => Float,
                                        :default   => 0.0,
                                        :validator => lambda {|value| value > 0 }},
                         :i_seq      => {:type     => Integer,
                                        :default   => 0,
                                        :validator => lambda {|value| value > 0 }}
        
        
        def initialize_copy(other)
          latitude  = other.latitude.clone
          longitude = other.longitude.clone
          elevation = other.elevation.clone if !elevation.nil?
        end
        
        def signed_latitude=(lat)
          @latitude.value = lat.abs
        end
        
        def signed_longitude=(lng)
          @longitude.value = lng.abs
        end        
                
        def type=(sym)
          @type = sym
        end
        
        def seq=(seq)
          @seq = seq
        end
        
        def seq
          @seq
        end
        
        def is_edge?
          type == :E or type == :C
        end                
        
        def is_inflection?
          type == :I or type == :C
        end
        
        def signed_latitude          
          @latitude.signed_value
        end
        
        def signed_longitude
          @longitude.signed_value
        end
        
        def more_north?(other)
          self.signed_latitude > other.signed_latitude
        end
        
        def more_south?(other)
          self.signed_latitude < other.signed_latitude
        end
        
        def more_east?(other)
          self.signed_longitude > other.signed_longitude
        end
        
        def more_west?(other)
          self.signed_longitude < other.signed_longitude
        end
        
        def distance_to(other)
           dx = self.signed_longitude - other.signed_longitude
           dy = self.signed_latitude  - other.signed_latitude
           Math.sqrt(dx**2 + dy**2)
        end
                
        def eql?(other)
            #self.signed_latitude == other.signed_latitude and self.signed_longitude == other.signed_longitude
            # one may have had formatting applied and the other not so ....
            lng1 = format(FLOAT_FORMAT, self.signed_longitude).to_f
            lng2 = format(FLOAT_FORMAT, other.signed_longitude).to_f
            
            lat1 = format(FLOAT_FORMAT, self.signed_latitude).to_f
            lat2 = format(FLOAT_FORMAT, other.signed_latitude).to_f
          
            dx = lng1 - lng2
            dy = lat1 - lat2
            0 == dx and 0 == dy
        end
        
        def within_radius?(other, tolerance = POINT_RADIUS)
            dy = self.signed_latitude  - other.signed_latitude
            dx = self.signed_longitude - other.signed_longitude
            dx.abs <= tolerance and dy.abs <= tolerance
        end
        
        def within_longitude_tolerance?(other, tolerance = POINT_RADIUS)
            dx = self.signed_longitude - other.signed_longitude
            dx.abs <= tolerance
        end
        
        def within_latitude_tolerance?(other, tolerance = POINT_RADIUS)
            dy = self.signed_latitude  - other.signed_latitude
            dy.abs <= tolerance
        end
                 
        def move_point(longitude=0, latitude=0)
          @longitude.value += longitude
          @latitude.value  += latitude
        end
        
        def to_s
          text = [longitude, latitude ].join ", "
          text << ", #{elevation}" unless elevation.nil?
          text
        end
       
        def to_cartesian(coordinate_system)
          (x, y) = ASAP::Utility::CoordinateSystemMapper::geographic_to_cartesian(coordinate_system, [longitude.signed_value, latitude.signed_value])
          CartesianPoint.new(:x => x, :y => y)
        end
      end

    end
  end
end