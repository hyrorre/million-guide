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
  order: 1001,
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
  order: 1002,
  added_on: Date.new(2017, 8, 22),
  updated_on: Date.new(2017, 8, 22),
  level_2m: 3,
  level_2mp: 10,
  level_4m: 6,
  level_6m: 11,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "utamas",
  title: "THE IDOLM@STER",
  kana: "THE IDOLM@STER",
  musictype: 3,
  order: 1003,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 2,
  level_2mp: 11,
  level_4m: 7,
  level_6m: 12,
  level_mm: 17,
  level_mmp: 0,
)
Music.create(
  idstr: "jibure",
  title: "自分REST＠RT",
  kana: "じぶんRESTART",
  musictype: 3,
  order: 1004,
  added_on: Date.new(2017, 10, 8),
  updated_on: Date.new(2017, 10, 8),
  level_2m: 4,
  level_2mp: 10,
  level_4m: 7,
  level_6m: 12,
  level_mm: 18,
  level_mmp: 0,
)
Music.create(
  idstr: "kokokae",
  title: "ココロがかえる場所",
  kana: "こころがかえるばしょ",
  musictype: 0,
  order: 2001,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 2,
  level_2mp: 8,
  level_4m: 5,
  level_6m: 9,
  level_mm: 13,
  level_mmp: 0,
)
Music.create(
  idstr: "sympho",
  title: "Blue Symphony",
  kana: "Blue Symphony",
  musictype: 1,
  order: 2002,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 3,
  level_2mp: 10,
  level_4m: 6,
  level_6m: 11,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "senti",
  title: "Sentimental Venus",
  kana: "Sentimental Venus",
  musictype: 1,
  order: 2003,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 4,
  level_2mp: 11,
  level_4m: 7,
  level_6m: 12,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "neversleep",
  title: "Marionetteは眠らない",
  kana: "Marionetteはねむらない",
  musictype: 2,
  order: 2004,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 4,
  level_2mp: 11,
  level_4m: 7,
  level_6m: 12,
  level_mm: 17,
  level_mmp: 0,
)
Music.create(
  idstr: "sss",
  title: "Shooting Stars",
  kana: "Shooting Stars",
  musictype: 1,
  order: 2005,
  added_on: Date.new(2017, 8, 12),
  updated_on: Date.new(2017, 8, 12),
  level_2m: 3,
  level_2mp: 10,
  level_4m: 7,
  level_6m: 12,
  level_mm: 17,
  level_mmp: 0,
)
Music.create(
  idstr: "goodsleep",
  title: "Good-Sleep, Baby♡",
  kana: "Good-Sleep, Baby♡",
  musictype: 2,
  order: 2006,
  added_on: Date.new(2017, 9, 8),
  updated_on: Date.new(2017, 9, 8),
  level_2m: 3,
  level_2mp: 9,
  level_4m: 6,
  level_6m: 10,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "grosto",
  title: "Growing Storm!",
  kana: "Growing Storm!",
  musictype: 0,
  order: 2007,
  added_on: Date.new(2017, 9, 30),
  updated_on: Date.new(2017, 9, 30),
  level_2m: 4,
  level_2mp: 11,
  level_4m: 7,
  level_6m: 11,
  level_mm: 17,
  level_mmp: 0,
)
Music.create(
  idstr: "fairytale",
  title: "FairyTaleじゃいられない",
  kana: "FairyTaleじゃいられない",
  musictype: 1,
  order: 2008,
  added_on: Date.new(2017, 10, 20),
  updated_on: Date.new(2017, 10, 20),
  level_2m: 4,
  level_2mp: 12,
  level_4m: 8,
  level_6m: 13,
  level_mm: 17,
  level_mmp: 0,
)
Music.create(
  idstr: "standing",
  title: "STANDING ALIVE",
  kana: "STANDING ALIVE",
  musictype: 2,
  order: 2009,
  added_on: Date.new(2017, 11, 1),
  updated_on: Date.new(2017, 11, 1),
  level_2m: 3,
  level_2mp: 9,
  level_4m: 6,
  level_6m: 11,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "anpara",
  title: "Angelic Parade♪",
  kana: "Angelic Parade",
  musictype: 2,
  order: 3012,
  added_on: Date.new(2017, 11, 21),
  updated_on: Date.new(2017, 11, 21),
  level_2m: 4,
  level_2mp: 9,
  level_4m: 8,
  level_6m: 11,
  level_mm: 17,
  level_mmp: 0,
)
Music.create(
  idstr: "sutekise",
  title: "素敵なキセキ",
  kana: "すてきなきせき",
  musictype: 0,
  order: 3001,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 3,
  level_2mp: 9,
  level_4m: 6,
  level_6m: 10,
  level_mm: 15,
  level_mmp: 0,
)
Music.create(
  idstr: "pregra",
  title: "Precious Grain",
  kana: "Precious Grain",
  musictype: 1,
  order: 3002,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 3,
  level_2mp: 9,
  level_4m: 5,
  level_6m: 10,
  level_mm: 17,
  level_mmp: 0,
)
Music.create(
  idstr: "lesson",
  title: "恋のLesson初級編",
  kana: "こいのLessonしょきゅうへん",
  musictype: 2,
  order: 3003,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 4,
  level_2mp: 10,
  level_4m: 7,
  level_6m: 11,
  level_mm: 15,
  level_mmp: 0,
)
Music.create(
  idstr: "ruriiro",
  title: "瑠璃色金魚と花菖蒲",
  kana: "るりいろきんぎょとはなしょうぶ",
  musictype: 1,
  order: 3004,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 4,
  level_2mp: 11,
  level_4m: 7,
  level_6m: 12,
  level_mm: 17,
  level_mmp: 0,
)
Music.create(
  idstr: "humming",
  title: "ハミングバード",
  kana: "はみんぐばーど",
  musictype: 2,
  order: 3005,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 2,
  level_2mp: 9,
  level_4m: 6,
  level_6m: 10,
  level_mm: 14,
  level_mmp: 0,
)
Music.create(
  idstr: "prologue",
  title: "透明なプロローグ",
  kana: "とうめいなぷろろーぐ",
  musictype: 0,
  order: 3006,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 3,
  level_2mp: 9,
  level_4m: 6,
  level_6m: 10,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "tokimekionpu",
  title: "トキメキの音符になって",
  kana: "ときめきのおんぷになって",
  musictype: 2,
  order: 3007,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 3,
  level_2mp: 9,
  level_4m: 6,
  level_6m: 10,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "smileichi",
  title: "スマイルいちばん",
  kana: "すまいるいちばん",
  musictype: 0,
  order: 3008,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 4,
  level_2mp: 10,
  level_4m: 7,
  level_6m: 11,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "locomo",
  title: "IMPRESSION→LOCOMOTION!",
  kana: "IMPRESSION→LOCOMOTION!",
  musictype: 1,
  order: 3009,
  added_on: Date.new(2017, 6, 29),
  updated_on: Date.new(2017, 6, 29),
  level_2m: 4,
  level_2mp: 13,
  level_4m: 8,
  level_6m: 13,
  level_mm: 18,
  level_mmp: 0,
)
Music.create(
  idstr: "happylucky",
  title: "ハッピー☆ラッキー☆ジェットマシーン",
  kana: "はっぴーらっきーじぇっとましーん",
  musictype: 0,
  order: 3010,
  added_on: Date.new(2017, 9, 20),
  updated_on: Date.new(2017, 9, 20),
  level_2m: 3,
  level_2mp: 9,
  level_4m: 6,
  level_6m: 10,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "afterschool",
  title: "アフタースクールパーリータイム",
  kana: "あふたーすくーるぱーりーたいむ",
  musictype: 1,
  order: 3011,
  added_on: Date.new(2017, 10, 11),
  updated_on: Date.new(2017, 10, 11),
  level_2m: 4,
  level_2mp: 10,
  level_4m: 7,
  level_6m: 11,
  level_mm: 16,
  level_mmp: 0,
)
Music.create(
  idstr: "happydarling",
  title: "Happy Darling",
  kana: "Happy Darling",
  musictype: 2,
  order: 3012,
  added_on: Date.new(2017, 11, 10),
  updated_on: Date.new(2017, 11, 10),
  level_2m: 4,
  level_2mp: 10,
  level_4m: 7,
  level_6m: 11,
  level_mm: 17,
  level_mmp: 0,
)