require_relative "modules"

class Station 
  extend  Counter::ClassMethods
  attr_reader :name, :trains

  def self.all 
    @trains
  end
  
  def initialize(name)
    @name = name
    @trains = []
    register_instance
  end

  def add_train_on_station(train)
    @trains << train
  end

  private
  include Counter::InstanceMethods
end
