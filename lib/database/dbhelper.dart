import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlitesample/models/carmodel.dart';


class DbHelper{

  static Database _db;

  final String tableCar = 'Cars';


  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnDescription = 'description';
  final String columnPrice = 'price';
  final String columnImageUrl = 'imageUrl';

  Future<Database> get db async {

    if(_db != null) return _db;

    _db = await initDb();

    return _db;

  }

  initDb() async {

    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'Cars2019.db');

    var MyDb = await openDatabase(path, version: 1, onCreate: _onCreate);

    return MyDb;

  }

  void _onCreate(Database db, int version) async{

    await db.execute('CREATE TABLE $tableCar ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnTitle TEXT, $columnDescription TEXT, $columnPrice INTEGER, $columnImageUrl TEXT)');

  }

  Future<int> deleteCar(int id) async{
    var dbClient = await db;
    await dbClient.transaction((txn) async{
      return await txn.rawDelete('DELETE FROM $tableCar WHERE $columnId = $id');
    });
    return 0;
  }

  Future<int> updateCar(Car car) async{
    var dbClient = await db;
    await dbClient.transaction((txn) async{
      return await txn.rawUpdate('UPDATE $tableCar SET $columnTitle = \'${car.title}\', $columnDescription= \'${car.description}\', $columnPrice = ${car.price}, $columnImageUrl = \'${car.imageUrl}\' WHERE $columnId = ${car.id} ');
    });
    return 0;
  }

  void saveCar(Car car) async{
    var dbClient = await db;
    await dbClient.transaction((txn) async{
      return await txn.rawInsert('INSERT INTO $tableCar ($columnTitle, $columnDescription, $columnPrice, $columnImageUrl) VALUES(\'${car.title}\', \'${car.description}\', ${car.price}, \'${car.imageUrl}\')');
    });
  }

  Future<List<Car>> getCars() async{

    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM $tableCar');

    List<Car> cars = List();

    for (int i=0; i<list.length; i++) {
      cars.add(Car(list[i]['id'], list[i]['title'], list[i]['description'], list[i]['price'], list[i]['imageUrl']));
    }

    return cars;

  }

}