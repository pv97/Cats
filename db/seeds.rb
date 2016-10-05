# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.create(name:"Hund",color:"black",sex:"M",birth_date:Date.today-10000)
Cat.create(name:"test",color:"red",sex:"F",birth_date:Date.today-1000)
Cat.create(name:"Mistake",color:"purple",sex:"M",birth_date:Date.today-1234)

CatRentalRequest.create(cat_id:1, start_date:Date.today-5, end_date: Date.today, status:"APPROVED")
CatRentalRequest.create(cat_id:1, start_date:Date.tomorrow, end_date: Date.tomorrow+7, status:"APPROVED")
CatRentalRequest.create(cat_id:1, start_date:Date.yesterday, end_date: Date.tomorrow+1, status:"DENIED")
CatRentalRequest.create(cat_id:3, start_date:Date.yesterday, end_date: Date.tomorrow+1)
