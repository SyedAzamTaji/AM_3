
import 'package:app/controller/theme_controller.dart';
import 'package:app/notification_service/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/dashboard/dashboard_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
    final ThemeController themeController = Get.put(ThemeController());
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        debugShowCheckedModeBanner: false, 
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
         themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
        home: Dashboard());
  }
}
