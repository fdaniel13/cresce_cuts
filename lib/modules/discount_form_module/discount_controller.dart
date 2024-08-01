import 'package:cresce_cuts/core/enums/type_discount_enum.dart';
import 'package:cresce_cuts/core/models/discounts_model.dart';
import 'package:cresce_cuts/core/models/products_model.dart';
import 'package:cresce_cuts/modules/discount_form_module/discount_repository.dart';
import 'package:mobx/mobx.dart';

part 'discount_controller.g.dart';

class DiscountController = DiscountControllerBase with _$DiscountController;

abstract class DiscountControllerBase with Store {
  final DiscountRepository _discountRepository;

  DiscountControllerBase(this._discountRepository);

  @observable
  TypeDiscountEnum? enumSelected;

  Future<List<ProductsModel>> getAllProducts() async {
    return await _discountRepository
        .fetchAllProducts()
        .then((value) => [...value.map((e) => ProductsModel.fromJson(e))]);
  }

  Future<bool> saveDiscount({required DiscountsModel discountsModel}) async {
 
configModelPerType(discountsModel);
    return await _discountRepository.creatDiscount(
        discountsModel: discountsModel);
  }
  
    Future updateDescount({ required DiscountsModel discountsModel}) async {
      configModelPerType(discountsModel);
      
    return await _discountRepository
        .updateDiscount(discountsModel: discountsModel);
  }

  void configModelPerType(DiscountsModel discountsModel){
     if (enumSelected == TypeDiscountEnum.levemaispaguemenos) {
      discountsModel.priceFor=null;
      discountsModel.priceFor=null;
      discountsModel.percentageDiscount=null;
    } else if (enumSelected == TypeDiscountEnum.percentual) {
      discountsModel.priceFor=null;
      discountsModel.priceFor=null;
      discountsModel.takeQuantity=null;
      discountsModel.buyQuantity=null;
    } else if (enumSelected == TypeDiscountEnum.precodeprecopor) {
      discountsModel.percentageDiscount=null;
      discountsModel.takeQuantity=null;
      discountsModel.buyQuantity=null;
    }
  }
}
