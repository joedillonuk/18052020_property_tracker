require('pry')
require_relative('models/property.rb')

Property.delete_all()

property1 = Property.new({
  'address' => '2 Lockkeepers Cottages',
  'value' => 2000000,
  'num_bedrooms' => 8,
  'year_built' => 1990,
  'buy_let_status' => 'Buy',
  'square_footage' => 2000,
  'build_type' => 'Detatched'
  })

  property2 = Property.new({
    'address' => '7 Galbraith Drive',
    'value' => 300000,
    'num_bedrooms' => 4,
    'year_built' => 1960,
    'buy_let_status' => 'Buy',
    'square_footage' => 500,
    'build_type' => 'Semi-Detached'

    })

    binding.pry
    property1.save()

p   Property.find_by_id(1)

p Property.find_by_address('2 Lockkeepers Cottages')

    binding.pry
    nil
