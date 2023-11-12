import 'package:flutter/widgets.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/controllers/todo_controller.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/repositories/todo_repository.dart';
import 'package:flutter_robinhood_siravit/core/services/api_service.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      TodoController(
        todoRepository: TodoRepository(
          ApiService.dio,
        ),
        pagingController: PagingController<int, MapEntry<DateTime, List<Task>>>(
          firstPageKey: 0,
        ),
        scrollController: ScrollController(),
      ),
    );
  }
}
