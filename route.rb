require_relative "modules"

class Route 
  extend  Counter::ClassMethods
  def initialize(name)
    @name = name
    @stations = []
    register_instance
  end

  def add_station(station)
    @stations << station
  end

  def delete_station(station)
    @stations.delete(station)
  end

  private
  include Counter::InstanceMethods
end
