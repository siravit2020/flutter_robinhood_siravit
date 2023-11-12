import 'package:flutter_robinhood_siravit/app/modules/main/models/todo_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/todo_test_data.dart';

void main() {
  group('TodoResponse', () {
    test('fromJson creates a valid TodoResponse', () {
      final todoResponse = TodoResponse.fromJson(testTodoJson);
      expect(todoResponse.tasks, isA<List<Task>>());
      expect(todoResponse, equals(testTodoResponse));
    });
    test('toJson creates a valid json', () {
      final todoResponse = testTodoResponse.toJson();
      expect(todoResponse, equals(testTodoJson));
    });
  });
}
