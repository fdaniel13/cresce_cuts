import 'package:cresce_cuts/core/helpers/database_helper/sqlite_helper.dart';
import 'package:cresce_cuts/core/services/api_service/dio_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cresce_cuts/modules/home_module/home_repository.dart';
import 'package:cresce_cuts/modules/home_module/home_controller.dart';
import 'package:cresce_cuts/modules/home_module/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.add(DioService.new);
    i.addSingleton(SqliteHelper.new);
    i.add(HomeRepository.new);
    i.add(HomeController.new);
  }

  @override
  void routes(r) {
    r.child('/',
        child: (context) => const HomePage(),
        transition: TransitionType.noTransition);
   
   
  }
}
