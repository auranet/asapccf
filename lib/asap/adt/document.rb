module ASAP
  module ADT

    class Document < ValidatableObject
      define_readers   :mime_type => {:type => String, :required => true, :converter => :to_s},
                       :content   => {                 :required => true}
    end
    
  end
end