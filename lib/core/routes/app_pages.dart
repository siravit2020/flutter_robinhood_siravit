import 'package:flutter_robinhood_siravit/app/modules/internet_connection/bindings/internet_connection_bindings.dart';
import 'package:flutter_robinhood_siravit/app/modules/internet_connection/views/screens/no_internet_screen.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/bindings/todo_bindings.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/views/screens/main_screen.dart';
import 'package:flutter_robinhood_siravit/app/modules/passcode_lock/bindings/passcode_bindings.dart';
import 'package:flutter_robinhood_siravit/app/modules/passcode_lock/views/screens/passcode_lock_screen.dart';
import 'package:flutter_robinhood_siravit/app/modules/splash/bindings/spalsh_bindings.dart';
import 'package:flutter_robinhood_siravit/app/modules/splash/views/screens/splash_screen.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const String networkError = '/network-error';
  static const String splash = '/';
  static const String main = '/main';
  static const String passcodeLock = '/passcode-lock';
}

class AppPages {
  static const String initial = Routes.splash;
  static final List<GetPage> routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.networkError,
      page: () => const NoInternetScreen(),
      binding: InternetConnectionBinding(),
    ),
    GetPage(
      name: Routes.passcodeLock,
      page: () => const PasscodeLockScreen(),
      binding: PasscodeLockBinding(),
    ),
    GetPage(
      name: Routes.main,
      page: () => const MainScreen(),
      binding: TodoBinding(),
    ),
  ];
}
