import 'package:flutter/material.dart';
import 'package:sqlitesample/database/dbhelper.dart';
import 'package:sqlitesample/models/carmodel.dart';

void main() async {
  var dbHelper = DbHelper();

  //Car car = Car(0, 'Mercedes', 'E250 CDI', 92000, 'Imagen');

  //Car car = Car(2,'Mercedes', 'E250 CDI', 82000, 'Imagen');

  //dbHelper.saveCar(car);

  //dbHelper.updateCar(car);

  dbHelper.deleteCar(1);

  //dbHelper.updateCar(car);
  //dbHelper.deleteCar(1);

  List<Car> list = await dbHelper.getCars();

  for(int i = 0; i < list.length; i++){

    print(' ${list[i].id}  ${list[i].title}');

  }

}

