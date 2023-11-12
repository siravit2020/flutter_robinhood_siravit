import 'package:flutter_robinhood_siravit/app/modules/passcode_lock/controllers/passcode_lock_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PasscodeLockController Tests', () {
    late PasscodeLockController passcodeLockController;

    setUp(() {
      Get.testMode = true;
      Get.put<PasscodeLockController>(PasscodeLockController());
      passcodeLockController = PasscodeLockController();
    });

    test('Test addPasscode', () {
      passcodeLockController.addPasscode('1');
      expect(passcodeLockController.passcode.value, '1');
    });

    test('Test addPasscode with full passcode', () {
      passcodeLockController.passcode.value = '123456';
      passcodeLockController.addPasscode('1');
      expect(passcodeLockController.passcode.value, '123456');
    });

    test('Test validatePasscode with correct passcode', () async {
      passcodeLockController.passcode.value = '123456';
      passcodeLockController.validatePasscode();
      expect(passcodeLockController.passcode.value, '123456');
    });

    test('Test validatePasscode with incorrect passcode', () async {
      passcodeLockController.passcode.value = '654321';
      passcodeLockController.validatePasscode();
      expect(passcodeLockController.passcode.value, '');
    });

    test('Test removePasscode', () {
      passcodeLockController.passcode.value = '123456';
      passcodeLockController.removePasscode();
      expect(passcodeLockController.passcode.value, '12345');
    });

    test('Test removePasscode with empty passcode', () {
      passcodeLockController.removePasscode();
      expect(passcodeLockController.passcode.value, '');
    });

    test('Test clearPasscode', () {
      passcodeLockController.passcode.value = '123456';
      passcodeLockController.clearPasscode();
      expect(passcodeLockController.passcode.value, '');
    });
  });
}
