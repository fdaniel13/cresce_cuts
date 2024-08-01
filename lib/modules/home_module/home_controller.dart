import 'package:cresce_cuts/core/models/discounts_model.dart';
import 'package:cresce_cuts/modules/home_module/home_repository.dart';

class HomeController {
  final HomeRepository _homeRepository;
  HomeController(this._homeRepository);

 

  Future<List<DiscountsModel>> getDescounts() async {
    return await _homeRepository
        .fetchAllDiscounts()
        .then((value) => [...value.map((e) => DiscountsModel.fromJson(e))]);
  }

    Future updateDescountSwicthValue({ required DiscountsModel discountsModel}) async {
    return await _homeRepository
        .updateDiscountState(discountsModel: discountsModel);
  }
}
