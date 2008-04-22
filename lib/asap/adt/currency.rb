module ASAP
  module ADT

    class Currency < ValidatableObject
      define_readers   :code => {:type => String, :default => "US$", :validator => lambda {|value| value == "US$"}}
      define_derivers  :name => {:deriver => lambda {"US Dollar"}}
    end
    
  end
end