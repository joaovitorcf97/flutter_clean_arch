import 'package:flutter/material.dart';
import 'package:flutter_clean_arch/core/di/injector_container.dart';
import 'package:flutter_clean_arch/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}
