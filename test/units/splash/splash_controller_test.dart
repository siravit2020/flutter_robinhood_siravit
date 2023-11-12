import 'package:flutter_robinhood_siravit/app/controllers/user_controller.dart';
import 'package:flutter_robinhood_siravit/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter_robinhood_siravit/core/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_controller_test.mocks.dart';

class MockUserController extends GetxController
    with Mock
    implements UserController {
  @override
  Future<bool> isLastActivityTimeExist() => super.noSuchMethod(
        Invocation.method(#isActive, []),
        returnValue: Future.value(true),
        returnValueForMissingStub: Future.value(true),
      );
}

@GenerateNiceMocks([
  MockSpec<InternetConnectionChecker>(),
])
void main() {
  group('SplashController Tests', () {
    late SplashController splashController;
    late MockUserController mockUserController;
    late MockInternetConnectionChecker mockInternetConnectionChecker;

    setUp(() {
      Get.testMode = true;
      mockUserController = MockUserController();
      Get.put<UserController>(mockUserController);
      mockInternetConnectionChecker = MockInternetConnectionChecker();
      splashController = SplashController(
        internetConnectionChecker: mockInternetConnectionChecker,
        userController: mockUserController,
      );
      Get.put<SplashController>(splashController);
    });

    test('Test Internet Connection Success and User Active', () async {
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      when(mockUserController.isLastActivityTimeExist())
          .thenAnswer((_) async => true);

      await splashController.onInit();

      expect(splashController.route, Routes.main);
    });

    test('Test Internet Connection Success and User Not Active', () async {
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);
      when(mockUserController.isLastActivityTimeExist())
          .thenAnswer((_) async => false);
      expect(await mockInternetConnectionChecker.hasConnection, true);
      expect(await mockUserController.isLastActivityTimeExist(), false);

      await splashController.onInit();

      verifyNever(mockUserController.onUserActivity());
      expect(splashController.route, Routes.passcodeLock);
    });

    test('Test Internet Connection Failure', () async {
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) async => false);

      await splashController.onInit();

      verifyNever(mockUserController.onUserActivity());
      expect(splashController.route, Routes.networkError);
    });
  });
}
