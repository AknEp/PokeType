#encoding: utf-8

require 'json'

json = JSON.load open('PokeList.json', 'r')
TYPES = [ "選択しない",
  "ノーマル",
  "ほのお",
  "みず",
  "でんき",
  "くさ",
  "こおり",
  "かくとう",
  "どく",
  "じめん",
  "ひこう",
  "エスパー",
  "むし",
  "いわ",
  "ゴースト",
  "ドラゴン",
  "あく",
  "はがね",
  "フェアリー",
  ]



puts "@{"

json.each do |poke|
  
  name = poke["name"]
  num = poke["num"].to_i
  types  = poke["type"]
  
  first_type_id = TYPES.index{ |name| name == types[0]}
  second_type_id = 0
  if types.length > 1
     second_type_id = TYPES.index{ |name| name == types[1].strip}
  end
  
  puts "@\"#{name}\" : @{@\"num\":@(#{num}), @\"types\":@[@(#{first_type_id}),@(#{second_type_id})] },"
  
  
  
  
end


puts '}'