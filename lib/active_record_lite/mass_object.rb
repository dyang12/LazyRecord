class MassObject
  def self.my_attr_accessible(*attributes)
    @attributes = []
    # write your own attr_accessor

    # @attributes = attributes
    # attr_accessor *attributes

    attributes.each do |attribute|
      attr_accessor attribute
      @attributes << attribute
    end
  end

  def self.attributes
    @attributes
  end

  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end

  def initialize(params = {})
    params.each do |key, value|
      if self.class.attributes.include?(key.to_sym)
        attribute = key.to_s + "="
        self.send(attribute.to_sym, value)
      else
        raise "mass assignment to unregistered attribute #{key}"
      end
    end
  end
end