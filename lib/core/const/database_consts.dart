String dbName = "discountsDatabase.db";
String tableDiscounts = "discounts";

String createTable = '''
CREATE TABLE IF NOT EXISTS $tableDiscounts(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      type TEXT,
      priceOf TEXT,
      priceFor TEXT,
      price TEXT,
      percentageDiscount TEXT,
      takeQuantity TEXT,
      buyQuantity TEXT,
      dateActivation TEXT,
      dateInactivation TEXT,
      imageUrl TEXT,
      actived BOOLEAN DEFAULT 1);
''';

String insertValues = '''
INSERT INTO $tableDiscounts 
(title ,
      description ,
      type ,
      priceOf ,
      priceFor ,
      price ,
      percentageDiscount ,
      takeQuantity ,
      buyQuantity ,
      dateActivation ,
      dateInactivation ,
      imageUrl ,
      actived)
 VALUES 
 ("Mens Casual Premium Slim Fit T-Shirts " ,
      "great outerwear jackets for Spring/Autumn/Winter, suitable for many occasions, such as working, hiking, camping, mountain/rock climbing, cycling, traveling or other outdoors. Good gift choice for you or your family member. A warm hearted love to Father, husband or son in this thanksgiving or Christmas Day." ,
      "percentual",
      "55.99" ,
      "35.99" ,
       "55.99" ,
      "15.00" ,
      2 ,
      3 ,
      "2024-04-21" ,
      "2024-04-29" ,
      "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
      1 );

''';
