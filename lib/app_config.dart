import 'package:test_api/test_api.dart';

class AppConfig extends Configuration {
  AppConfig(String fileName) : super.fromFile(File(fileName));
  
  DatabaseConfiguration database;
}