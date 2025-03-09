import 'package:expense/pages/add.dart';
import 'package:expense/pages/delete.dart';
import 'package:expense/pages/details.dart';
import 'package:expense/pages/home.dart';
import 'package:expense/pages/preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/expenses_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ExpensesController());
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
                name: "/details",
                page: () => const Details()
            ),
            GetPage(
              name: "/preferences",
              page: () => const Preferences(),
            ),
            GetPage(
              name: "/deleteRestore",
              page: () => const Delete(),
            ),
            GetPage(name: "/add", page: () => Add())
          ],
        ),
      ],
    );
  }
}
