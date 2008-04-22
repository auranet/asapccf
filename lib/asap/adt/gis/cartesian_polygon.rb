module ASAP
  module ADT
    module GIS
      
      class CartesianPolygon < CartesianPointContainer
        define_accessors :vertices       => {:type      => Array,
                                             :default   => [],
                                             :validator => lambda {|value| value.all? {|vertex| vertex.kind_of? CartesianPoint}}},
                         :holes =>          {:type => Array,
                                             :default => [],
                                             :validator => lambda {|value| value.all? {|hole| hole.kind_of? Array}}}
        
        def to_s
          unit.to_s << ": " << vertices.join("; ")
        end
        
        def number_of_vertices
          vertices.size
        end
        
        def lines
          result = nil
          
          if vertices
            vertices.each_with_index do |vertex, index|
              if index == 0
                if vertices.size > 1
                  line = generate_line
                  line.endpoints = [vertices[-1], vertices[0]]  # Add the last-to-first closing line segment.
                  result = [line]
                else
                  result = []
                end
              else
                line = generate_line
                line.endpoints = [vertices[index - 1], vertex]
                result << line
              end
            end
          end
          
          result
        end
        
        def to_geographic(coordinate_system)
          geographic_polygon = generate_geographic_polygon
          vertices.each do |cartesian_point|
            geographic_polygon.vertices << cartesian_point.to_geographic(coordinate_system)
          end
          geographic_polygon
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
        
        def generate_point(*arguments, &block)
          CartesianPoint.new(*arguments, &block)
        end
      end

    end
  end
end