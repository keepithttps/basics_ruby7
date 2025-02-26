require_relative "passenger_train"
require_relative "cargo_train"
require_relative "station"
require_relative "route"
require_relative "wagon"
require_relative "passenger_wagon"
require_relative "cargo_wagon"
require_relative "modules"



@trains   = {}
@stations = {}
@routes   = {}

def prompt(msg)
  puts msg 
  print "=> "
  gets.chomp 
end


def create_train
  number = prompt("Введите номер поезда")
  type = prompt("Укажите тип поезда (1 - пассажирский, 2 - грузовой)")
  train = case type
  when "1" then PassengerTrain.new(number)
  when "2" then CargoTrain.new(number)
  end
  @trains[number] = train
end

def create_station
  name = prompt("Введите название станции")
  station = Station.new(name)
  @stations[name] = station
end

def create_route
  name = prompt("Введите название маршрута")
  route = Route.new(name)
  @routes[name] = route
end

def add_station
  route_name = prompt("Введите название маршрут")
  station_name = prompt("Введите название станции")
  route   = @routes[route_name]
  station = @stations[station_name]
  route.add_station(station)
end

def delete_station
  route_name = prompt("Введите название маршрут")
  station_name = prompt("Введите название станции")
  route   = @routes[route_name]
  station = @stations[station_name]
  route.delete_station(station)
end

def add_wagon
  train_name   = prompt("Введите название поезда")
  number_wagon = prompt("Введите номер вагона")
  type_wagon   = prompt("Введите тип вагон - (1 - cargo, 2 - pessenger)")
  train = @trains[train_name]
  wagon = if type_wagon == "1"
    CargoWagon.new(number_wagon)
  elsif type_wagon == "2"
    PassengerWagon.new(number_wagon)
  end
  train.add_wagon(wagon)
end

def delete_wagon
  train_name   = prompt("Введите название поезда")
  number_wagon = prompt("Введите номер вагона")
  train = @trains[train_name]
  train.delete_wagon(number_wagon)
end

def assign_route
  route_name = prompt("Введите название маршрут")
  train_name   = prompt("Введите название поезда")
  train   = @trains[train_name]
  route   = @routes[route_name]
  train.add_route(route)
end

def go_forward
  train_name   = prompt("Введите название поезда")
  train   = @trains[train_name]
  train.go_next_station
end

def go_back
  train_name   = prompt("Введите название поезда")
  train   = @trains[train_name]
  train.go_previous_station
end

def list_station
  @stations.keys
end

def show_trains
  station_name = prompt("Введите название станции")
  station = @stations[station_name]
  station.trains
end

loop do
  input = prompt(
    "1.  Зарегистрировать поезд\n" \
    "2.  Зарегистрировать станцию\n" \
    "3.  Создать маршрут\n" \
    "---\n" \
    "4.  Добавить станцию в маршрут\n" \
    "5.  Убрать станцию из маршрута\n" \
    "---\n" \
    "6.  Прицепить вагон\n" \
    "7.  Отцепить вагон\n" \
    "8.  Назначить маршрут\n" \
    "---\n" \
    "9.  Отправить поезд вперёд по маршруту\n" \
    "10. Отправить поезд назад по маршруту\n" \
    "---\n" \
    "11. Посмотреть список станций\n" \
    "12. Посмотреть список поездов на станции\n" \
    "---\n" \
    "13. Закрыть программу" 
  )
  case input
  when "1"
    create_train
    puts @trains
  when "2"
    create_station
    puts @stations
  when "3"
    create_route
    puts @routes
  when "4"
    add_station
  when "5"
    delete_station
  when "6"
    add_wagon
  when "7"
    delete_wagon
  when  "8"
    assign_route
  when "9"
    go_forward
  when "10"
    go_back
  when "11"
    list_station
  when "12"
    show_trains
  when "13"
    break
  else
    puts "Пока в разработке"
  end
end
