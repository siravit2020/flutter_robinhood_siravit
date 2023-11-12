import 'package:flutter/material.dart';
import 'package:flutter_robinhood_siravit/app/controllers/user_controller.dart';
import 'package:flutter_robinhood_siravit/core/themes/theme.dart';
import 'package:flutter_robinhood_siravit/core/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  setupController();
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fade,
      theme: defaultTheme(context),
      themeMode: ThemeMode.light,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}

void setupController() {
  Get.put(UserController(box: GetStorage()));
}
