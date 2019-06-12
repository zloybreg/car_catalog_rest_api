import 'test_api.dart';

class TestApiChannel extends ApplicationChannel {
  
  ManagedContext context;

  final dbConfig = AppConfig("config.yaml");

  /// Initialize services in this method.
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      dbConfig.database.username, 
      dbConfig.database.password, 
      dbConfig.database.host, 
      dbConfig.database.port, 
      dbConfig.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);
  }

  @override
  Controller get entryPoint => Router()
      ..route("/example").linkFunction((request) async => 
        Response.ok({"key": "value"}))
      //
      ..route('/reads/[:id]').link(() => CarsController(context));
}