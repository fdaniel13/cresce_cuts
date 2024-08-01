
import 'package:cresce_cuts/core/models/discounts_model.dart';
import 'package:cresce_cuts/modules/discount_form_module/discount_controller.dart';
import 'package:cresce_cuts/modules/discount_form_module/discount_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';



class MockDiscountRepository extends Mock implements DiscountRepository{

  @override
  Future<List> fetchAllProducts() async {
    return [{ "title":"titulo",
   "price":2.4,
   "category":"categoria 2"},
   { "title":"titulo",
   "price":2.4,
   "category":"categoria"}];
}
@override
Future<bool> creatDiscount({required DiscountsModel discountsModel}) async{
  try{
  return true;}
  catch(e){
    return false;
  }
}

}



void main(){
final MockDiscountRepository mockDiscountRepository= MockDiscountRepository();
    final discountController = DiscountController(mockDiscountRepository);

  setUp(() {

  });

  test('Should return the value category of the ProductsModel', () async{
    final list = await discountController.getAllProducts();
    expect(list.first.category, "categoria 2");
  });

    test('Should return a List with two element', () async{
    final list = await discountController.getAllProducts();
    expect(list.length, 2);
  });

  
    test('Should create a Discount', () async{
    final value = await discountController.saveDiscount(discountsModel: DiscountsModel());
    expect(value, true);
  });

}
