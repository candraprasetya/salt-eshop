import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salt_test/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final root = await getApplicationDocumentsDirectory();
  Hive.init(root.path);

  runApp(const MyApp());
}
