import 'package:cresce_cuts/modules/discount_detail_module/discount_detail_controller.dart';
import 'package:cresce_cuts/modules/discount_detail_module/discount_detail_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockDiscountDetailRepository extends Mock implements DiscountDetailRepository{

  @override
  Future<List> fetchDiscount({required int id}) async {
    return [{ "title":"titulo",
   "price":2.4,
   },
   ];
}

}



void main(){
final MockDiscountDetailRepository mockDiscountRepository= MockDiscountDetailRepository();
    final discountDetailController = DiscountDetailController(mockDiscountRepository);

  setUp(() {

  });

  test('Should return a DiscountModel', () async{
    final value = await discountDetailController.getDescounts(id: 1);
    expect(value.title, "titulo");
  });

    test('Should return a string of a subtraction', () {
    final price =  discountDetailController.diffCalcDescount(priceFor: 10,priceOf: 20);
    expect(price, "10.00");
  });

  
    test('Should return a String of  value minus a percentage ', () {
    final value =  discountDetailController.percentCalcDescount(percent: 50,number: 100);
    expect(value, "50.00");
  });

}
