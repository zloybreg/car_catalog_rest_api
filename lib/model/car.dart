import 'package:test_api/test_api.dart';

class Car extends ManagedObject<_Car> implements _Car{
  @Serialize()
  String get detail => '$model by $manufacture in $yearOfManufacture';
}


class _Car {
  @primaryKey
  int id;

  @Column()
  String model;

  @Column()
  String manufacture;

  @Column()
  int yearOfManufacture;
}