# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create an initial admin user if one does not exist
admin = Employee.create!(
  name: "Admin User",
  email: "user@mail.com",
  password: "123456",
  fiscal_number: "123456",
)

puts "Created admin user: #{admin.email}"

# Create some locations in the city
count = 0
["Warehouse A", "Warehouse B", "Customer 1", "Customer 2", "Avenidad Siempre viva 123", "Waterhouse 3000"].each do |location_name|
  Location.create!(name: location_name, address_line: "#{location_name} #{count}")
end

puts "Created locations"

# Create a driver
4.times do |i|
  Driver.create!(name: "Driver #{i + 1}", fiscal_number: "FISCAL#{i + 1}", phone: "555-000#{i + 1}")
end

Driver.last.status_suspended!

puts "Created drivers"

# Create vehicle type
vehicle_type = VehicleType.create!(name: "Truck")
vehicle_type = VehicleType.create!(name: "Bike", active: false)

puts "Created vehicle types"

# Create some vehicles

3.times do |i|
  Vehicle.create!(
    plate: "ABC-12#{i + 1}",
    vehicle_type: VehicleType.first
  )
end

Vehicle.last.status_suspended!
