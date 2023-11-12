import 'package:flutter_robinhood_siravit/app/modules/internet_connection/controllers/internet_connection_controller.dart';
import 'package:get/get.dart';

class InternetConnectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetConnectionController());
  }
}
