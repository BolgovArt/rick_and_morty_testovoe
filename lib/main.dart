import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/di/service_locator.dart';
import 'package:rick_and_morty_testovoe/domain/services/api_service.dart';
import 'package:rick_and_morty_testovoe/domain/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final sharedPreferences = await SharedPreferences.getInstance();
  final storageService = StorageService(sharedPreferences: sharedPreferences);
  final apiService = ApiService();

  final appFactory = makeAppFactory(
    sharedPreferences: sharedPreferences,
    storageService: storageService,
    apiService: apiService,
  );
  
  runApp(appFactory.makeApp());
}