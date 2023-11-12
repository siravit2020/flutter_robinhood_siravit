import 'package:flutter/widgets.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/controllers/todo_controller.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart';
import 'package:flutter_robinhood_siravit/core/utils/enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../data/todo_test_data.dart';
import 'todo_controller_test.mocks.dart';
import 'todo_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ScrollController>(),
  MockSpec<PagingController>(),
])
void main() {
  group('TodoController Tests', () {
    late TodoController todoController;
    late MockTodoRepository mockTodoRepository;
    late MockPagingController<int, MapEntry<DateTime, List<Task>>>
        mockPagingController;

    setUp(() {
      Get.testMode = true;
      mockTodoRepository = MockTodoRepository();
      mockPagingController =
          MockPagingController<int, MapEntry<DateTime, List<Task>>>();
      todoController = TodoController(
        todoRepository: mockTodoRepository,
        pagingController: mockPagingController,
        scrollController: MockScrollController(),
      );
      Get.put<TodoController>(todoController);
    });

    test('Initial values are set correctly', () {
      expect(todoController.pagingController.firstPageKey, 0);
      expect(todoController.sortType.value, TodoSortType.asc);
      expect(todoController.status, TodoStatus.todo);
      expect(todoController.scrollController.offset, 0.0);
      expect(todoController.limit, 10);
    });

    test('Change Tab updates status and refreshes paging controller', () {
      todoController.changeTab(TodoStatus.doing);
      expect(todoController.status, TodoStatus.doing);
      verify(todoController.pagingController.refresh()).called(1);
      todoController.changeTab(TodoStatus.done);
      expect(todoController.status, TodoStatus.done);
      verify(todoController.pagingController.refresh()).called(1);
    });

    test('Change Sort Type updates sortType and refreshes paging controller',
        () {
      todoController.changeSortType(TodoSortType.desc);
      expect(todoController.sortType.value, TodoSortType.desc);
      verify(todoController.pagingController.refresh()).called(1);
      todoController.changeSortType(TodoSortType.asc);
      expect(todoController.sortType.value, TodoSortType.asc);
      verify(todoController.pagingController.refresh()).called(1);
    });

    test('Test mapData', () async {
      final tasks = testTodoResponseStatusTodo.tasks;
      final data = todoController.mapData(tasks);
      expect(data, isA<List<MapEntry<DateTime, List<Task>>>>());
    });

    test('Test addPage last page', () async {
      final mapList = [
        MapEntry(DateTime.now(), [
          Task(
            id: 'ab7e3eb3-058d-44de-bb97-01b35d2b2c29',
            title: 'Pay bills',
            description: 'Pay monthly bills and schedule future payments',
            createdAt: DateTime.parse('2023-03-25T14:00:00Z'),
            status: TodoStatus.todo,
          ),
        ])
      ];
      const isLastPage = true;
      todoController.addPage(
        pageKey: 1,
        mapList: mapList,
        isLastPage: isLastPage,
      );
      verify(mockPagingController.appendLastPage(mapList)).called(1);
    });

    test('Test addPage with existing itemList', () async {
      const pageKey = 2;
      final now = DateTime.now();
      final mapList = [
        MapEntry(now, [
          Task(
            id: '119a8c45-3f3d-41da-88bb-423c5367b81a',
            title: 'Exercise',
            description: 'Go for a run or do a workout at home',
            createdAt: DateTime.parse('2023-03-25T09:00:00Z'),
            status: TodoStatus.todo,
          ),
        ])
      ];
      const isLastPage = false;
      todoController.addPage(
        pageKey: pageKey,
        mapList: mapList,
        isLastPage: isLastPage,
      );
      when(mockPagingController.itemList).thenReturn(mapList);
      final add = [
        MapEntry(now, [
          Task(
            id: 'ab7e3eb3-058d-44de-bb97-01b35d2b2c29',
            title: 'Pay bills',
            description: 'Pay monthly bills and schedule future payments',
            createdAt: DateTime.parse('2023-03-25T14:00:00Z'),
            status: TodoStatus.todo,
          ),
        ])
      ];
      todoController.addPage(
        pageKey: pageKey,
        mapList: add,
        isLastPage: isLastPage,
      );
      expect(mockPagingController.itemList!.length, 1);
      expect(mockPagingController.itemList![0].value.length, 2);
    });

    test('Test fetchPage success', () async {
      const pageNumber = 1;
      const limit = 10;
      const status = TodoStatus.todo;
      const isAsc = true;
      final response = TodoResponse(
        pageNumber: pageNumber,
        totalPages: 2,
        tasks: [
          Task(
            id: '1',
            title: 'Task 1',
            description: 'Description 1',
            createdAt: DateTime.parse('2022-01-01T00:00:00.000Z'),
            status: TodoStatus.todo,
          ),
          Task(
            id: '2',
            title: 'Task 2',
            description: 'Description 2',
            createdAt: DateTime.parse('2022-01-01T00:00:00.000Z'),
            status: TodoStatus.todo,
          ),
        ],
      );
      when(mockTodoRepository.getTodoList(
        offset: pageNumber,
        limit: limit,
        status: status.name.toUpperCase(),
        isAsc: isAsc,
      )).thenAnswer((_) async => response);
      await todoController.fetchPage(pageNumber);
      verify(mockTodoRepository.getTodoList(
        offset: pageNumber,
        limit: limit,
        status: status.name.toUpperCase(),
        isAsc: isAsc,
      )).called(1);
      verify(mockPagingController.appendPage(any, pageNumber + 1)).called(1);
    });

    test('Test removeTask', () async {
      const index = 0;
      final tasks = [
        Task(
          id: '1',
          title: 'Task 1',
          description: 'Description 1',
          createdAt: DateTime.parse('2022-01-01T00:00:00.000Z'),
          status: TodoStatus.todo,
        ),
        Task(
          id: '2',
          title: 'Task 2',
          description: 'Description 2',
          createdAt: DateTime.parse('2022-01-01T00:00:00.000Z'),
          status: TodoStatus.todo,
        ),
      ];
      final itemList = [MapEntry(DateTime.now(), tasks)];
      when(mockPagingController.itemList).thenReturn(itemList);
      todoController.removeTask(index: index, task: tasks[0]);
      expect(mockPagingController.itemList![index].value, [
        Task(
          id: '2',
          title: 'Task 2',
          description: 'Description 2',
          createdAt: DateTime.parse('2022-01-01T00:00:00.000Z'),
          status: TodoStatus.todo,
        )
      ]);
      todoController.removeTask(index: index, task: tasks[0]);
      expect(mockPagingController.itemList!.isEmpty, true);
    });
  });
}
