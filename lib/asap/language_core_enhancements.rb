# Define the patches.

module ClassModifications

  def abstract(*method_names)
    method_names.each do |method_name|
      define_method(method_name) do |*arguments|
        if method_name == :initialize
          message = "#{self.class.name} is an abstract class."
        else
          message = "#{self.class.name}##{method_name} is an abstract method."
        end
        raise NotImplementedError, message
      end
    end
  end

end

module ArrayModifications
  
  def circularize
    def self.[](i)         super(i % self.size)        end
    def self.[]=(i, value) super(i % self.size, value) end
    return self
  end
  
end

module HashModifications
  
  def augment!(hash)
    hash.each do |key, value|
      store(key, value) unless fetch(key, false)
    end
  end
  
end

module FloatModifications
  
  def approx(other, factor = 1, epsilon = Float::EPSILON)
    (other - self).abs <= (factor * epsilon)
  end
  
end

module StringModifications

  def capitalize_words
    split.each {|word| word.capitalize!}.join ' '
  end
  
  def to_class_name
    capitalize.gsub(/_(.)/) { |s| $1.capitalize }
  end
  
  def to_html
    self
  end

end

module TrueClassModifications

  def to_html
    "X"
  end

end

module FalseClassModifications

  def to_html
    "&nbsp;"
  end

end

module DateModifications

  def to_html
    to_s
  end

end

module TimeModifications

  def to_sql
    strftime('%H:%M:%S')
  end

  def to_html
    strftime('%I:%M %p')
  end

end

module DateTimeModifications

  def to_html
    to_s
  end

end

# For now, just go ahead and include all the patches.

class Array
  include ArrayModifications
end

class Hash
  include HashModifications
end

class Float
  include FloatModifications
end

class Class
  include ClassModifications
end

class String
  include StringModifications
end

class TrueClass
  include TrueClassModifications
end

class FalseClass
  include FalseClassModifications
end

class Date
  include DateModifications
end

class Time
  include TimeModifications
end

class DateTime < Date
  include DateTimeModifications
end
