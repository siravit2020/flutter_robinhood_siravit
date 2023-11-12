import 'package:flutter/material.dart';
import 'package:flutter_robinhood_siravit/app/modules/passcode_lock/controllers/passcode_lock_controller.dart';
import 'package:flutter_robinhood_siravit/app/modules/passcode_lock/views/widgets/numpad.dart';
import 'package:flutter_robinhood_siravit/app/modules/passcode_lock/views/widgets/passcode.dart';
import 'package:flutter_robinhood_siravit/core/constants/constants.dart';
import 'package:get/get.dart';

class PasscodeLockScreen extends GetView<PasscodeLockController> {
  const PasscodeLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter passcode',
              style: TextStyleSet.paragraph400,
            ),
            const SizedBox(
              height: Spacing.spacing32,
            ),
            Obx(
              () => Passcode(
                passcode: controller.passcode.value,
              ),
            ),
            const SizedBox(
              height: Spacing.spacing32,
            ),
            Numpad(
              onTab: (value) {
                controller.addPasscode(value);
              },
              onCancel: () {
                controller.clearPasscode();
              },
              onRemove: () {
                controller.removePasscode();
              },
            )
          ],
        ),
      ),
    );
  }
}
