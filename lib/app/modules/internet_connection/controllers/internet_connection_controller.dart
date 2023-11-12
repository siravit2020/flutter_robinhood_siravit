import 'package:flutter_robinhood_siravit/app/controllers/user_controller.dart';
import 'package:flutter_robinhood_siravit/core/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionController extends GetxController {
  static InternetConnectionController get to => Get.find();
  UserController userActivityController = UserController.to;

  Future<bool> get hasConnection async =>
      (await InternetConnectionChecker().hasConnection);

  void retryConnec() async {
    if (await hasConnection) {
      Get.offNamed(Routes.splash);
    }
  }
}
