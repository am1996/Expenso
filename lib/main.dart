import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/expenses_controller.dart';
import 'package:myapp/pages/add.dart';
import 'package:myapp/pages/delete.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/pages/preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenso',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: "/home",
      initialBinding:
          BindingsBuilder(() => Get.lazyPut(() => ExpensesController())),
      getPages: <GetPage>[
        GetPage(
          name: "/home",
          page: () => const HomePage(),
          children: [
            GetPage(
              name: "/preferences",
              page: () => const Preferences(),
            ),
            GetPage(
              name: "/deleterestore",
              page: () => const Delete(),
            ),
            GetPage(name: "/add", page: () => Add())
          ],
        ),
      ],
    );
  }
}
