import 'package:cresce_cuts/core/helpers/database_helper/sqlite_helper.dart';
import 'package:cresce_cuts/core/services/api_service/dio_service.dart';
import 'package:cresce_cuts/modules/discount_detail_module/discount_detail_controller.dart';
import 'package:cresce_cuts/modules/discount_detail_module/discount_detail_page.dart';
import 'package:cresce_cuts/modules/discount_detail_module/discount_detail_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DiscountDetailModule extends Module {
  @override
  void binds(i) {
    i.add(DioService.new);
    i.addSingleton(SqliteHelper.new);
    i.add(DiscountDetailRepository.new);
    i.add(DiscountDetailController.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) => const DiscountDetailPage(),
        transition: TransitionType.noTransition);
   
   
  }
}
