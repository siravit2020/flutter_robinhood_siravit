import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_robinhood_siravit/app/controllers/user_controller.dart';
import 'package:flutter_robinhood_siravit/core/routes/app_pages.dart';

class SplashController extends GetxController {
  SplashController({
    required this.userController,
    required this.internetConnectionChecker,
  });

  final UserController userController;
  final InternetConnectionChecker internetConnectionChecker;

  static SplashController get to => Get.find();

  late String route;

  @override
  Future<void> onInit() async {
    await navigateTo();
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(route);
    super.onInit();
  }

  Future<void> navigateTo() async {
    bool connection = await internetConnectionChecker.hasConnection;
    if (connection == true) {
      if (await userController.isLastActivityTimeExist()) {
        route = Routes.main;
      } else {
        route = Routes.passcodeLock;
      }
    } else {
      route = Routes.networkError;
    }
  }
}
