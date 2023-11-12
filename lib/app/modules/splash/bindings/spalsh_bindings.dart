import 'package:flutter_robinhood_siravit/app/controllers/user_controller.dart';
import 'package:flutter_robinhood_siravit/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      SplashController(
        internetConnectionChecker: InternetConnectionChecker(),
        userController: UserController.to,
      ),
    );
  }
}
