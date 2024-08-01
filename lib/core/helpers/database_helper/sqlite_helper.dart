
import 'package:cresce_cuts/core/const/database_consts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class SqliteHelper{

  SqliteHelper();
  static Database? _database;
  
  Future<Database> get database async{
    if (_database !=null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), dbName), version: 1, onCreate: _onCreateDB);
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute(createTable).then((value) async=> await db.execute(insertValues));
  }
}
