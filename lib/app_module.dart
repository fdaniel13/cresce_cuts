import 'package:cresce_cuts/modules/discount_detail_module/discount_detail_module.dart';
import 'package:cresce_cuts/modules/discount_form_module/discount_module.dart';
import 'package:cresce_cuts/modules/home_module/home_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(Modular.initialRoute,
        module: HomeModule(), transition: TransitionType.noTransition);
    r.module("/addDiscounts",
        module: DiscountsModule(), transition: TransitionType.noTransition);
    r.module("/discountDetail",
        module: DiscountDetailModule(), transition: TransitionType.noTransition);
  }
}
