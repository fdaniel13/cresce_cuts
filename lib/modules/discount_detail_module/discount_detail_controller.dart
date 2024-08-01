import 'package:cresce_cuts/core/models/discounts_model.dart';
import 'package:cresce_cuts/modules/discount_detail_module/discount_detail_repository.dart';


 class DiscountDetailController   {
  final DiscountDetailRepository _discountDetailRepository;
  DiscountDetailController(this._discountDetailRepository);

  Future<DiscountsModel> getDescounts({required int id}) async {
    return await _discountDetailRepository.fetchDiscount(id: id).then((value) {
      DiscountsModel discountsModel = DiscountsModel.fromJson(value.first);
      return discountsModel;
    });
  }
    Future updateDescountSwicthValue({ required DiscountsModel discountsModel}) async {
    return await _discountDetailRepository
        .updateDiscountState(discountsModel: discountsModel);
  }
  String percentCalcDescount(
          {required double percent, required double number}) =>
      (number - (number * percent / 100)).toStringAsFixed(2);
  String diffCalcDescount(
          {required double priceFor, required double priceOf}) =>
      (priceOf - priceFor).toStringAsFixed(2);
}
