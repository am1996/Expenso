import 'package:expense/pages/add.dart';
import 'package:expense/pages/details.dart';
import 'package:expense/pages/income.dart';
import 'package:expense/pages/export_income.dart';
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
      initialRoute: "/income",
      initialBinding:
          BindingsBuilder(() => Get.lazyPut(() => ExpensesController())),
      getPages: <GetPage>[
        GetPage(
          name: "/income",
          page: () => const IncomePage(),
          children: [
            GetPage(
                name: "/details",
                page: () => const Details()
            ),
            GetPage(name: "/add", page: () => Add()),
            GetPage(name: "/export", page: () => ExportIncome())
          ],
        ),
      ],
    );
  }
}
