class Module
  def my_attr_reader(*attributes)
    attributes.each do |attribute|
      define_method attribute do
        instance_variable_get "@#{attribute}"
      end
    end
  end

  def my_attr_writer(*attributes)
    attributes.each do |attribute|
      define_method "#{attribute}=" do |value|
        instance_variable_set "@#{attribute}", value
      end
    end
  end

  def my_attr_accessor(*attributes)
    my_attr_reader(*attributes)
    my_attr_writer(*attributes)
  end
end

class Singer
  my_attr_writer :first_name
  my_attr_reader :last_name
  my_attr_accessor :birth_year, :greatest_hit

  def initialize(first_name, last_name, birth_year, greatest_hit)
    @first_name = first_name
    @last_name = last_name
    @birth_year = birth_year
    @greatest_hit = greatest_hit
  end

  # An example of a getter (or "reader") if we didn't use attr_reader
  def first_name
    @first_name
  end

  # An example of a setter (or "writer") if we didn't use attr_writer
  def last_name=(value)
    @last_name = value
  end

  def to_s
    "#{first_name} #{last_name}, born in #{birth_year}, greatest hit: \"#{greatest_hit}\""
  end
end

sinatra = Singer.new("Nancy", "Sinatra", 1940, "These Boots Are Made for Walkin'")

puts sinatra

sinatra.first_name = "Frank"
sinatra.birth_year = 1915
sinatra.greatest_hit = "My Way"

puts sinatra
