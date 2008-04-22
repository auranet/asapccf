module ASAP
  module ADT
  
    class Name < ValidatableObject
      define_accessors :prefix  => {},
                       :last    => {},
                       :first   => {},
                       :middle  => {},
                       :suffix  => {}
      
      def full_formal
        [prefix, first, middle, last, suffix].reject {|element| element.nil? || element.empty?}.join " "
      end
      
      def full_alphabetic
        [last, first].reject {|element| element.nil? || element.empty?}.join ", "
      end
      
      def full_casual
        [first, last].reject {|element| element.nil? || element.empty?}.join " "
      end
    end
      
  end
end