import 'package:cresce_cuts/core/const/database_consts.dart';
import 'package:cresce_cuts/core/helpers/database_helper/sqlite_helper.dart';
import 'package:cresce_cuts/core/models/discounts_model.dart';

class DiscountDetailRepository {
  final SqliteHelper _sqliteHelper;
  DiscountDetailRepository( this._sqliteHelper);

  //Get one  discounts
  Future<List> fetchDiscount({required int id}) async {
    try {
      return await _sqliteHelper.database
          .then((db) async => await db.query(tableDiscounts,where: 'id=?',whereArgs:[id] ));
    } catch (error) {
      return [];
    }
  }
      //update  discount
  Future<int> updateDiscountState({ required DiscountsModel discountsModel}) async {
    try {
      
      return await _sqliteHelper.database
          .then((db) async => await db.update(tableDiscounts,discountsModel.toJson(),where: "id=?",whereArgs:[discountsModel.id] ));
    } catch (error) {
      return 0;
    }
  }
}
