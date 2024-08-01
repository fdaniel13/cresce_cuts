import 'package:cresce_cuts/modules/home_module/home_controller.dart';
import 'package:cresce_cuts/modules/home_module/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHomeRepository extends Mock implements HomeRepository{

  @override
  Future<List> fetchAllDiscounts() async {
    return [{ "title":"titulo",
   "price":2.4,
   "description":"descricao"}];
  }
}

void main(){
final MockHomeRepository mockHomeRepository= MockHomeRepository();
    final homeController = HomeController(mockHomeRepository);

  setUp(() {

  });

  test('Should return the value price of the Discount', () async{
    final list = await homeController.getDescounts();
    expect(list.first.price, 2.4);
  });

    test('Should return a List with one element', () async{
    final list = await homeController.getDescounts();
    expect(list.length, 1);
  });
}
