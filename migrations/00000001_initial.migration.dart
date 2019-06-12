import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Car", [
        SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
        SchemaColumn("model", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
        SchemaColumn("manufacture", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
        SchemaColumn("yearOfManufacture", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)
      ]));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {
    List<Map<String, dynamic>> cars = [
      {
        'model' : 'Mazda 6',
        'manufacture' : 'Japan',
        'yearOfManufacture' : 2001
      },
      {
        'model' : 'Kia Optima',
        'manufacture' : 'Korea',
        'yearOfManufacture' : 2002
      },
      {
        'model' : 'Toyota Camry',
        'manufacture' : 'Japan',
        'yearOfManufacture' : 2003
      }
    ];

    for (final car in cars) {
      await database.store.execute(
        'INSERT INTO _Car (model, manufacture, yearOfManufacture) VALUES (@model, @manufacture, @yearOfManufacture)',
        substitutionValues: {
          'model' : car['model'],
          'manufacture' : car['manufacture'],
          'yearOfManufacture' : car['yearOfManufacture']
        }
      );
    }
  }
}
    