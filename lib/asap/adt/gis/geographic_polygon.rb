module ASAP
  module ADT
    module GIS
          
      class GeographicPolygon < GeographicPointContainer
        define_accessors :vertices  => {:type      => Array,
                                        :default   => [],
                                        :validator => lambda {|value| value.all? {|vertex| vertex.kind_of? GeographicPoint}}}
        
        def to_s
          vertices.join "; "
        end
        
        def number_of_vertices
          vertices.size
        end
        
        def to_cartesian(coordinate_system)
          # FIXME: we shouldn't have to init :unit here, ValidatableObject needs repaired
          cartesian_polygon = generate_cartesian_polygon(:coordinate_system => coordinate_system, :unit => coordinate_system.unit, :vertices => [])
          vertices.each do |geographic_point|
            cartesian_polygon.vertices << geographic_point.to_cartesian(coordinate_system)
          end
          #cartesian_polygon.vertices.each {|vertex| p vertex} #DEBUG
          cartesian_polygon
        end
        
        alias method_missing_standard_procedure method_missing
        def method_missing(method, *arguments, &block)
          if self.vertices
            self.vertices.send method, *arguments, &block
          else
            method_missing_standard_procedure method, *arguments, &block
          end
        end
        
        protected
        
        def generate_cartesian_polygon(*arguments, &block)
          CartesianPolygon.new(*arguments, &block)
        end
        
        def generate_point(*arguments, &block)
          GeographicPoint.new(*arguments, &block)
        end
      end

    end
  end
end