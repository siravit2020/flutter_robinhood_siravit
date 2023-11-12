import 'package:flutter_robinhood_siravit/app/controllers/user_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'user_controller_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetStorage>(),
])
void main() {
  group('UserController Tests', () {
    late UserController userController;
    late MockGetStorage mockGetStorage;

    setUp(() {
      Get.testMode = true;
      mockGetStorage = MockGetStorage();
      Get.put<GetStorage>(mockGetStorage);
      userController = UserController(box: mockGetStorage);
      Get.put<UserController>(userController);
    });

    test('Test User Active', () async {
      when(mockGetStorage.read('lastActivityTime'))
          .thenReturn(DateTime.now().millisecondsSinceEpoch);
      final isActive = await userController.isLastActivityTimeExist();
      expect(isActive, true);
    });

    test('Test User Inactive', () async {
      final lastActivityTime = DateTime.now()
          .subtract(const Duration(milliseconds: 15000))
          .millisecondsSinceEpoch;
      when(mockGetStorage.read('lastActivityTime'))
          .thenReturn(lastActivityTime);
      final isActive = await userController.isLastActivityTimeExist();
      expect(isActive, false);
    });

    test('Test User Activity', () async {
      final lastActivityTime = DateTime.now()
          .subtract(const Duration(milliseconds: 9000))
          .millisecondsSinceEpoch;
      when(mockGetStorage.read('lastActivityTime'))
          .thenReturn(lastActivityTime);
      expect(await userController.isLastActivityTimeExist(), true);
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      when(mockGetStorage.write('lastActivityTime', any))
          .thenAnswer((_) async => currentTime);
      when(mockGetStorage.read('lastActivityTime')).thenReturn(currentTime);
      userController.onUserActivity();
      await Future.delayed(const Duration(milliseconds: 2000));
      final isActive = await userController.isLastActivityTimeExist();
      expect(isActive, true);
    });
  });
}
