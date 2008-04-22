module ASAP
  module ADT
  
    class AttributeValidationError < RuntimeError
      
      attr_accessor :object_class, :attribute_name
      
      def initialize(proposed_object_class, proposed_attribute_name = nil, proposed_message = nil)
        object_class = proposed_object_class
        attribute_name = proposed_attribute_name
        super formatted_message(proposed_object_class, proposed_attribute_name, proposed_message)
      end
      
      def formatted_message(object_class, attribute_name, message)
        "#{object_class} #{attribute_name}: " + message
      end
      
    end
    
  end
end
