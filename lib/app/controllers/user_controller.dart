import 'dart:async';
import 'package:flutter_robinhood_siravit/core/utils/my_logger.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_robinhood_siravit/core/routes/app_pages.dart';
import 'package:restart_app/restart_app.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();
  Timer? _inactivityTimer;
  final int milliseconds = 10000;
  final GetStorage box;

  UserController({
    required this.box,
  });

  Future<bool> isLastActivityTimeExist() async {
    final lastActivityTime = box.read('lastActivityTime') ?? 0;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeSinceLastActivity = currentTime - lastActivityTime;
    return timeSinceLastActivity < milliseconds;
  }

  void onUserActivity() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(Duration(milliseconds: milliseconds), () {
      if (Get.currentRoute != Routes.passcodeLock) {
        logger.i('User inactive for $milliseconds milliseconds');
        Restart.restartApp();
      }
    });
    box.write('lastActivityTime', DateTime.now().millisecondsSinceEpoch);
  }
}
