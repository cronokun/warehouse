Box.create([
  {name: 'Small',    volume: 1},
  {name: 'Medium',   volume: 3},
  {name: 'Big',      volume: 5},
  {name: 'Very Big', volume: 10}
])

Product.create([
  { name: 'Product X',
    product_number: 'ABC 12000-3450-67',
    width: 100,
    height: 100,
    depth: 10,
    weight: 50,
    stock_level: 1000 },

  { name: 'Product Y',
    product_number: 'ABC 13000-4560-78',
    width: 100,
    height: 20,
    depth: 55,
    weight: 75,
    stock_level: 800 },

  { name: 'Product Z',
    product_number: 'ABC 14000-5670-89',
    width: 150,
    height: 20,
    depth: 65,
    weight: 20,
    stock_level: 1200 }
])
