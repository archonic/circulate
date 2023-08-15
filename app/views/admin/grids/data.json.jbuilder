json.items do
  json.array! @items do |item|
    json.id item.id
    json.number item.complete_number
    json.name item.name
    # json.categories item.category_nodes.map { |cn| cn.path_names.join("//") }.sort.join("; ")
    # json.description item.description
    json.status item.status
    json.size item.size
    json.brand item.brand
    json.model item.model
    json.serial item.serial
    json.strength item.strength
    json.power_source item.power_source
    json.other_names item.other_names
  end
end