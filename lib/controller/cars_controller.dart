import 'package:test_api/test_api.dart';

class CarsController extends ResourceController {

  CarsController(this.context);

  ManagedContext context;
  
  @Operation.get()
  Future<Response> getAllCars() async {
    final carQuery = Query<Car>(context);
   
    return Response.ok(await carQuery.fetch());
  }

  @Operation.get('id')
  Future<Response> getCar(@Bind.path('id') int id) async {
    
    final carQuery = Query<Car>(context)
      ..where((car) => car.id).equalTo(id);

    final car = await carQuery.fetchOne();
  
    if (car == null) {
      return Response.notFound(body: 'Item not found');
    }
    
    return Response.ok(car);
  }

  @Operation.post()
  Future<Response> createNewCar(@Bind.body() Car body) async {

    final carQuery = Query<Car>(context)
      ..values = body;

    final insertedCar = await carQuery.insert();

    return Response.ok(insertedCar);
  }

  @Operation.put('id') 
  Future<Response> updateCar(@Bind.path('id') int id, @Bind.body() Car body) async {
    
    final carQuery = Query<Car>(context)      
      ..where((car) => car.id).equalTo(id)
      ..values = body;

    final updatedCar = await carQuery.update();

    if (updatedCar == null) {
      return Response.notFound(body: 'Item not found');
    }

    return Response.ok(updatedCar);
  }

  @Operation.delete('id')
  Future<Response> deleteCar(@Bind.path('id') int id) async {

    final carQuery = Query<Car>(context)      
      ..where((car) => car.id).equalTo(id);

    final deletedCount = await carQuery.delete();

    if (deletedCount == null) {
      return Response.notFound(body: 'Item not found');
    }

    return Response.ok('Deleted count $deletedCount');
  }
}