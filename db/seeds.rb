# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Music.create(
  idstr: "brand",
  title: "Brand New Theater!",
  kana: "Brand New Theater!",
  musictype: 3,
  order: 1,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 3,
  level_2mp: 10,
  level_4m: 6,
  level_6m: 11,
  level_mm: 15,
  level_mmp: 0,
)
Music.create(
  idstr: "thankyou",
  title: "Thank You!",
  kana: "Thank You!",
  musictype: 3,
  order: 2,
  added_on: Date.new(2017, 8, 22),
  updated_on: Date.new(2017, 8, 22),
  level_2m: 3,
  level_2mp: 10,
  level_4m: 6,
  level_6m: 11,
  level_mm: 16,
  level_mmp: 0,
)
