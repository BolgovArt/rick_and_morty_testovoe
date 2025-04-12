import 'package:flutter/material.dart';
import 'package:rick_and_morty_testovoe/di/service_locator.dart';
import 'package:rick_and_morty_testovoe/widgets/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
  
}