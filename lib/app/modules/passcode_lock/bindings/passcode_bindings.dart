import 'package:flutter_robinhood_siravit/app/modules/passcode_lock/controllers/passcode_lock_controller.dart';
import 'package:get/get.dart';

class PasscodeLockBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PasscodeLockController());
  }
}
