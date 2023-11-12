import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart';
import 'package:flutter_robinhood_siravit/core/utils/enum.dart';
import 'package:flutter_robinhood_siravit/core/utils/my_logger.dart';
import 'package:get/get.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/repositories/todo_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TodoController extends GetxController {
  static TodoController get to => Get.find();

  TodoController({
    required this.todoRepository,
    required this.pagingController,
    required this.scrollController,
  });

  final TodoRepository todoRepository;
  final PagingController<int, MapEntry<DateTime, List<Task>>> pagingController;
  final ScrollController scrollController;
  final Rx<TodoSortType> sortType = TodoSortType.asc.obs;
  TodoStatus status = TodoStatus.todo;

  @override
  Future<void> onInit() async {
    pagingController.addPageRequestListener((int pageKey) {
      fetchPage(pageKey);
      logger.i('pageKey: $pageKey');
    });
    super.onInit();
  }

  void changeTab(TodoStatus status) {
    scrollController.jumpTo(0);
    this.status = status;
    pagingController.refresh();
  }

  void changeSortType(TodoSortType sortType) {
    this.sortType.value = sortType;
    pagingController.refresh();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final TodoResponse response = await todoRepository.getTodoList(
        offset: pageKey,
        limit: 10,
        status: status.name.toUpperCase(),
        isAsc: sortType.value == TodoSortType.asc,
      );
      final bool isLastPage = response.pageNumber == response.totalPages;
      final data = mapData(response.tasks);
      addPage(pageKey: pageKey, mapList: data, isLastPage: isLastPage);
    } catch (error) {
      logger.e(error);
      pagingController.error = error;
    }
  }

  List<MapEntry<DateTime, List<Task>>> mapData(List<Task> tasks) {
    final Map<DateTime, List<Task>> groupedData = groupBy(
      tasks,
      (item) {
        final localDate = item.createdAt.toLocal();
        final date = DateTime(localDate.year, localDate.month, localDate.day);
        return date;
      },
    );
    return groupedData.entries.toList();
  }

  void addPage({
    required int pageKey,
    required List<MapEntry<DateTime, List<Task>>> mapList,
    required bool isLastPage,
  }) {
    if (isLastPage) {
      pagingController.appendLastPage(mapList);
    } else {
      final nextPageKey = pageKey + 1;
      if (pagingController.itemList != null) {
        if (pagingController.itemList!.last.key == mapList.first.key) {
          pagingController.itemList!.last.value.addAll(mapList.first.value);
          mapList.removeAt(0);
        }
        pagingController.appendPage(mapList, nextPageKey);
      } else {
        pagingController.appendPage(mapList, nextPageKey);
      }
    }
  }

  void removeTask({required int index, required Task task}) {
    pagingController.itemList![index].value.remove(task);
    if (pagingController.itemList![index].value.isEmpty) {
      pagingController.itemList!.removeAt(index);
    }
    update();
  }
}
