import 'package:contact_app_exam/pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/databaseController.dart';
import 'helper/databaseHelper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.dbHelper.initDb();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DbController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
