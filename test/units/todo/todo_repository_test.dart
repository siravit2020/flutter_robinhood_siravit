import 'package:dio/dio.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart';
import 'package:flutter_robinhood_siravit/app/modules/main/repositories/todo_repository.dart';
import 'package:flutter_robinhood_siravit/core/utils/enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'todo_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodoRepository>()])
void main() {
  group('TodoRepository Tests', () {
    late MockTodoRepository todoRepository;

    setUp(() {
      todoRepository = MockTodoRepository();
    });

    test('Test getTodoList Success', () async {
      final response = TodoResponse(
        tasks: [
          Task(
            id: '1',
            title: 'Task 1',
            description: 'Description 1',
            createdAt: DateTime.parse('2022-01-01T00:00:00.000Z'),
            status: TodoStatus.todo,
          )
        ],
        pageNumber: 0,
        totalPages: 5,
      );
      when(todoRepository.getTodoList()).thenAnswer((_) async => response);

      final result = await todoRepository.getTodoList();

      expect(result, isA<TodoResponse>());
      expect(result, response);
    });

    test('Test getTodoList Failure', () async {
      when(todoRepository.getTodoList()).thenThrow(DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      ));

      expect(
        () async => await todoRepository.getTodoList(),
        throwsA(isInstanceOf<DioException>()),
      );
    });
  });
}
