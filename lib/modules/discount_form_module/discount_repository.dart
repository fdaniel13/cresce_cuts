import 'package:cresce_cuts/core/const/api_routs.dart';
import 'package:cresce_cuts/core/const/database_consts.dart';
import 'package:cresce_cuts/core/helpers/database_helper/sqlite_helper.dart';
import 'package:cresce_cuts/core/models/discounts_model.dart';
import 'package:cresce_cuts/core/services/api_service/dio_service.dart';

class DiscountRepository {
  final DioService _dioService;
  final SqliteHelper _sqliteHelper;
  DiscountRepository(this._dioService, this._sqliteHelper);

  //Get all products
  Future<List> fetchAllProducts() async {
    try {
      return await _dioService.dio
          .get(getAllProducts)
          .then((value) => value.data);
    } catch (error) {
      return [];
    }
  }

  //Creat discounts
  Future<bool> creatDiscount({required DiscountsModel discountsModel}) async {
    try {
      await _sqliteHelper.database.then((db) async =>
          await db.insert(tableDiscounts, discountsModel.toJson()));
      return true;
    } catch (error) {
      return false;
    }
  }

        //update  discount
  Future<int> updateDiscount({ required DiscountsModel discountsModel}) async {
    try {
      
      return await _sqliteHelper.database
          .then((db) async => await db.update(tableDiscounts,discountsModel.toJson(),where: "id=?",whereArgs:[discountsModel.id] ));
    } catch (error) {
      return 0;
    }
  }
}
