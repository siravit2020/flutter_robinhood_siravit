import 'package:flutter_robinhood_siravit/app/widgets/custom_alert_dialog.dart';
import 'package:flutter_robinhood_siravit/core/routes/app_pages.dart';
import 'package:get/get.dart';

class PasscodeLockController extends GetxController {
  static PasscodeLockController get to => Get.find();

  final RxString passcode = ''.obs;
  final Rx<RxStatus> status = RxStatus.empty().obs;

  @override
  void onInit() {
    status.listen((value) {
      if (value.isSuccess) {
        Get.offNamed(Routes.main);
      } else {
        Get.dialog(
          CustomAlertDialog.error(content: value.errorMessage!),
        );
      }
    });
    super.onInit();
  }

  void addPasscode(String value) {
    if (passcode.value.length < 6) {
      passcode.value += value;
    }
    if (passcode.value.length == 6) {
      validatePasscode();
    }
  }

  void validatePasscode() async {
    if (passcode.value == '123456') {
      status.value = RxStatus.success();
    } else {
      status.value = RxStatus.error('Invalid passcode');
      clearPasscode();
    }
  }

  void removePasscode() {
    if (passcode.value.isNotEmpty) {
      passcode.value = passcode.value.substring(0, passcode.value.length - 1);
    }
  }

  void clearPasscode() {
    passcode.value = '';
  }
}
