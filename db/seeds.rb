# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Station.destroy_all
s1 = Station.create :address => "100 George Street Sydney, NSW 2000"
s2 = Station.create :address => "100 Pitt Street Sydney, NSW 2000"
s3 = Station.create :address => "100 Elizabeth Street Sydney, NSW 2000"
