import 'package:cresce_cuts/core/helpers/database_helper/sqlite_helper.dart';
import 'package:cresce_cuts/core/services/api_service/dio_service.dart';
import 'package:cresce_cuts/modules/discount_form_module/discount_controller.dart';
import 'package:cresce_cuts/modules/discount_form_module/discount_page.dart';
import 'package:cresce_cuts/modules/discount_form_module/discount_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DiscountsModule extends Module {
  @override
  void binds(i) {
    i.add(DioService.new);
    i.addSingleton(SqliteHelper.new);
    i.add(DiscountRepository.new);
    i.add(DiscountController.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) => const DiscountsPage(),
        transition: TransitionType.noTransition);
   
   
  }
}
