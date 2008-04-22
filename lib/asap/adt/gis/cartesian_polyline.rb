module ASAP
  module ADT
    module GIS
      
      class CartesianPolyline < CartesianPointContainer
        define_accessors :vertices  => {:type      => Array,
                                        :default   => [],
                                        :validator => lambda {|value| value.all? {|vertex| vertex.kind_of? CartesianPoint}}}
        
        def to_s
          unit.to_s << ": " << vertices.join("; ")
        end        
        
        def number_of_vertices
          vertices.size
        end
        
        def number_of_lines
          vertices.size - 1
        end
        
        def lines
          result = nil
          
          if vertices
            vertices.each_with_index do |vertex, index|
              if index == 0
                result = []
              else
                line = generate_line
                line.endpoints = [vertices[index - 1], vertex]
                result << line
              end
            end
          end
          
          result
        end
        
        def reverse
          new_polyline = clone.reverse!
          new_polyline
        end
        
        alias method_missing_standard_procedure method_missing
        def method_missing(method, *arguments, &block)
          self.vertices ||= []
          self.vertices.send method, *arguments, &block
        end
      end

    end
  end
end